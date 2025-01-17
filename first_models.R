# first models
library(terra)
library(tidyverse)
library(predicts) # remotes::install_github("rspatial/predicts")
source("R/functions.R")


## A GLM with random backgound points

# sample random background points
n_background_points <- 100

random_bg <- terra::spatSample(
  x = kenya_mask,
  size = n_background_points,
  na.rm = TRUE,
  as.points = TRUE
)

# our presence data is collected in biased fashion
sample_locations_bias_weighted

#let's just use the 3 key covariates for now:
covs
plot(covs)


# combine data for analysis
sdm_data_1 <- make_sdm_data(
  presences = sample_locations_bias_weighted,
  absences = random_bg,
  covariates = covs
)


# fit a model!

model_1 <- glm(
  occ ~ tseas + tmax + trange,
  data = sdm_data_1,
  family = binomial()
)

summary(model_1)

# look at the partial_response

pr1_tseas <- partialResponse(
  model = model_1,
  data = sdm_data_1 %>% filter(occ == 1),
  "tseas"
)

prplot(pr1_tseas) # something wrong here showing linear correlation


pr1_tmax <- partialResponse(
  model = model_1,
  data = sdm_data_1 %>% filter(occ == 1),
  "tseas"
)

prplot(pr1_tseas) # something wrong here showing linear correlation


pr1_tseas <- partialResponse(
  model = model_1,
  data = sdm_data_1 %>% filter(occ == 1),
  "tseas"
)

plot(pr1_tseas, type = "l") # something wrong here showing linear correlation

# predict our distribution based on our model and covariates
prediction_1 <- sdm_predict(model_1, covs)

# plot it
plot(prediction_1)

# plot it against the 'truth'
plot(c(prediction_1, rel_abund))

## AUC stuff needs to go in here


## A GLM using target-group background points


# presences are from our focal species 1

presences_tgb <- species_df

# our presence data is collected in biased fashion
sample_locations_bias_weighted

#let's just use the 3 key covariates for now:
covs
plot(covs)


# combine data for analysis
sdm_data_1 <- make_sdm_data(
  presences = sample_locations_bias_weighted,
  absences = random_bg,
  covariates = covs
)


# fit a model!

model_1 <- glm(
  occ ~ tseas + tmax + trange,
  data = sdm_data_1,
  family = binomial()
)

summary(model_1)

# look at the partial_response

pr1_tseas <- partialResponse(
  model = model_1,
  data = sdm_data_1 %>% filter(occ == 1),
  "tseas"
)

prplot(pr1_tseas) # something wrong here showing linear correlation


pr1_tmax <- partialResponse(
  model = model_1,
  data = sdm_data_1 %>% filter(occ == 1),
  "tseas"
)

prplot(pr1_tseas) # something wrong here showing linear correlation


pr1_tseas <- partialResponse(
  model = model_1,
  data = sdm_data_1 %>% filter(occ == 1),
  "tseas"
)

plot(pr1_tseas, type = "l") # something wrong here showing linear correlation


