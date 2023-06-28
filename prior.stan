generated quantities {
  real alpha;
  real lambda;
  real child_mortality;
  real food_supply_coef;
  real co2_emission_coef;
  real med_beds_coef;
  real food_supply;
  real co2_emission;
  real med_beds;

  food_supply_coef = normal_rng(0.2, 0.1);
  med_beds_coef = normal_rng(0.2, 0.1);
  co2_emission_coef = normal_rng(0.2, 0.1);

  food_supply = normal_rng(0, 1);
  med_beds = normal_rng(0, 1);
  co2_emission = normal_rng(0, 1);

  alpha = normal_rng(2, 1);
  lambda = exp(alpha + co2_emission_coef * co2_emission + food_supply_coef * food_supply + med_beds_coef * med_beds);  
  child_mortality = poisson_rng(lambda);
}