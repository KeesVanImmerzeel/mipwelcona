# Function to calculate the cumulative probability or nonexceedance probability of the Pearson Type III
# distribution.
# @param x A real value vector and a vector of parameter values for the distribution specified by type.
#       so x[1]=x; x[2:4]=c(mu, sigma, gamma)
# @return Nonexceedance probability (F) for x.
.p3 <- function(x) {
  #print(x)
  vec <- c(x[2:4])
  x <- x[1]
  # Convert a Vector of Parameters to a Parameter Object of a Distribution
  p <- lmomco::vec2par(vec, 'pe3')
  # cumulative probability or nonexceedance probability of the Pearson Type III distribution given parameters (μ, σ, and γ)
  return(lmomco::cdfpe3(x, para = p))
}

# Calculate fraction of each change in concentration on streamline "data" at t using Pearson III (cumulative).
.calc_f <- function(t, data) {
  cbind(t, data$TIME, data$sigma, data$gamma, row.names = NULL) %>% as.matrix() %>% apply(MARGIN = 1, .p3)
}

# Calculate the sum of the product of all fractions (ref. "calc_f") with the changes in concentrations
# on streamline "data". Add to initial concentration (conc0).
.disp_conc <- function(f, data, conc0) {
  conc0 + sum(f[2:length(f)] * data$D_CCONC)
}

# Function to add PearsonIII parameters sigma en gamma to conc_strm_lns table (as variables).
# in case the process of dispersion is included.
.addPearsonParameters <-
  function(conc_strm_lns,
           alpha = 0.3,
           rho = 3) {
    conc_strm_lns %<>%
      dplyr::mutate(b = TIME / rho) %>%
      dplyr::mutate(a = DIST * (1 - 1 / rho) / (TIME * 2 * alpha)) %>%
      dplyr::mutate(n = DIST * ((1 - 1 / rho) ^ 2) / (2 * alpha)) %>%
      dplyr::mutate(sigma = sqrt(n) / a) %>%
      dplyr::mutate(gamma = 2 / sqrt(n)) %>%
      dplyr::select(-c(a, n))
    return(conc_strm_lns)
  }

# Calculate the concentrations on streamline "data" (a tibble, ref. \code{\link{mw_init}) at "times" (numeric vector).
#
# @inheritParams mw_conc_streamlines
# @return data frame with the following variables (columns):
# * SL_NR: Streamline number (integer)
# * TIME: Time, days (numeric)
# * CONC: Concentration (numeric)
.f <- function(data,
               SL_NR,
               times,
               processes = c("retardation"),
               alpha = 0.3,
               rho = 3,
               labda = 0.0001,
               retard = 1) {
  if ("retardation" %in% processes) {
    data$TIME <- data$TIME / retard
    alpha <- alpha / retard
  }
  if ("dispersion" %in% processes) {
    conc <- rep(data$CCONC[1], length(times)) # Concentration at t=0
    if (nrow(data) >= 2) {
      # More then 2 concentrations in table
      flt_data <- data %>% dplyr::filter(TIME > 0)
      f <-
        purrrlyr::by_row(times %>% as.data.frame(),
                         .calc_f,
                         data = flt_data,
                         .collate = "cols")
      conc <-
        purrrlyr::by_row(
          f %>% as.data.frame(),
          .disp_conc,
          data = flt_data,
          conc = conc[1],
          # Concentration at t=0
          .collate = "cols"
        )
      conc <-
        conc[, ncol(conc)] %>% as.data.frame() %>% dplyr::rename(CONC = .out)
    }
  } else {
    # Conservative
    conc <- stats::approx(
      data$TIME,
      y = data$CCONC,
      xout = times,
      method = "constant",
      rule = c(2:2)
    )$y
  }
  if ("decay" %in% processes) {
    conc <- conc * exp(-labda * times)
  }
  return(data.frame(
    SL_NR = SL_NR,
    TIME = times,
    CONC = conc
  ))
}

#' Calculate concentrations on streamlines at specified times.
#'
#' @param conc_strm_lns Table (tibble) with output of function \code{\link{mw_init}}
#' @param times Times at which to calculate concentrations (days) (numeric)
#' @param processes Processes to include in concentration calculations. (character).
#'   Options are: "dispersion", "retardation", "decay"
#' @param alpha Dispersivity (m) (numeric).
#' @param rho Fraction between the time of arrival of the front and the average time of arrival (-) (numeric)
#' @param labda Decay rate in exponential formula (day-1) (numeric)
#' @param retard Retardation (-) (numeric)
#' @return tibble with the following variables (columns):
#' * SL_NR: Streamline number (integer)
#' * TIME: Time, days (numeric)
#' * CONC: Concentration (numeric)
# @examples
# x <- .mw_conc_streamlines(conc_strm_lns=chk_mw_init, times=c(1*365,5*365,10*365,25*365), processes=c("dispersion","decay", "retardation"), alpha=0.3, rho=3, labda=0.0001, retard=1)
# @export
.mw_conc_streamlines <-
  function(conc_strm_lns,
           times = c(0, 1 * 365, 5 * 365, 10 * 365, 25 * 365),
           processes = c("retardation"),
           alpha = 0.3,
           rho = 3,
           labda = 0.0001,
           retard = 1) {
    if ("dispersion" %in% processes) {
      conc_strm_lns %<>% .addPearsonParameters(alpha, rho)
    }
    x <- conc_strm_lns %>% dplyr::group_map(
      ~ .f(
        .x,
        SL_NR = .y$SL_NR,
        times = times,
        processes = processes,
        alpha = alpha,
        rho = rho,
        labda = labda,
        retard = retard
      )
    ) %>% dplyr::bind_rows()
    return(x)
  }
