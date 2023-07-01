data {
  int N;  
  int child_mortality[N];  
  real co2_emission[N]; 
  real food_supply[N];  
  real med_beds[N];  
  real gender_equality[N];
}

parameters {
  real alpha; 
  real co2_emission_coef;
  real food_supply_coef; 
  real med_beds_coef; 
  real gender_equality_coef;
}

transformed parameters {
    real lambda[N];
    for (i in 1:N){
        lambda[i] = exp(alpha + co2_emission_coef * co2_emission[i] + food_supply_coef * food_supply[i] + med_beds_coef * med_beds[i] + gender_equality_coef * gender_equality[i]);  
    }
}

model {
  alpha ~ normal(2, 1);
  food_supply_coef ~ normal(0.5, 0.1);
  med_beds_coef ~ normal(0.5, 0.1);
  co2_emission_coef ~ normal(0.5, 0.1);
  gender_equality_coef ~ normal(0.5, 0.1); 

  for (i in 1:N){
      child_mortality[i] ~ poisson(lambda[i]);
  }
}

generated quantities {
  vector [N] log_lik;
  real predicted_child_mortality[N];
  for (i in 1:N) {
    log_lik[i] = poisson_lpmf(child_mortality[i] | lambda[i]);
    predicted_child_mortality[i] = poisson_rng(lambda[i]);
  }
}