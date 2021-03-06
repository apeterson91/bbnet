## code to prepare `network_benvo` dataset goes here

set.seed(234131)
num_subj <- 2E3
sex <- rbinom(n = num_subj,size=1,prob = .5)
centered_income <- rlnorm(n=num_subj,mean= 0,log(1.5))
subj_pos <- cbind(runif(num_subj),runif(num_subj))
FFRpos <- cbind(runif(30),runif(30))
subj_FFR <- fields::rdist(subj_pos,FFRpos)
FFR_FFR <- fields::rdist(FFRpos,FFRpos)
f_direct <- function(x) .3*pweibull(x,shape=5,scale=.6,lower.tail = F)
f_indirect <- function(x) .1*pweibull(x,shape=4,scale=.3,lower.tail=F)
FFRexposure <- apply(subj_FFR,1,function(x) {sum(f_direct(x))})
FFR_sq_exposure <- sapply(1:num_subj,function(x) {
  ics <- which(subj_FFR[x,]<=.5)
  mat <- FFR_FFR[ics,]
  sum(f_indirect(mat[lower.tri(mat)]))
  })

y <- 25 + sex*-2  + centered_income*-2  + FFRexposure + FFR_sq_exposure + rnorm(num_subj,sd = .5)


subj_df <- dplyr::tibble(ID = 1:num_subj,
                         BMI = y,
                         sex = sex,
                         FFR_exposure = FFRexposure,
                         FFR_sq_exposure = FFR_sq_exposure)

FFR_df <- purrr::map_dfr(1:num_subj,function(x) dplyr::tibble(ID = x,
                                                       Distance = subj_FFR[x,]))

FFR_df <- FFR_df %>% dplyr::filter(Distance<=1)

FFR_FFR_df <- purrr::map_df(1:num_subj,function(x) {
  ics <- which(subj_FFR[x,]<=.5)
  mat <- FFR_FFR[ics,]
  out <- dplyr::tibble(ID = x,
                       Distance = mat[lower.tri(mat)])
  return(out)
  })

FFR_FFR_df <- FFR_FFR_df %>% dplyr::filter(Distance<=1)

network_benvo <- rbenvo::benvo(subject_data = subj_df,
                               sub_bef_data = list(`Direct FFR`=FFR_df,
                                                   `Indirect FFR`=FFR_FFR_df),by="ID")


usethis::use_data(network_benvo, overwrite = TRUE)
