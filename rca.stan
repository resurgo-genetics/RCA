data {
    int<lower = 1> N;
    int<lower = 1> G;
    int<lower = 0> P;  // Number of known covariates

    vector[G] Y[N];
    vector[P] Z[N];  // Known covariates
}
transformed data{
    vector[2] O;
    matrix[2, 2] I;
    
    O[1] = 0.;
    O[2] = 0.;

    I[1, 1] = 1.;
    I[1, 2] = 0.;
    I[2, 1] = 0.;
    I[2, 2] = 1.;
}
parameters {
    vector[2] X[N];
    vector[G] mu;
    matrix[G, 2] W;
    matrix[G, P] V;

    real<lower = 0> s2_model;
}
model {
    for (n in 1:N){
        X[n] ~ multi_normal(O, I);
    }

    for (n in 1:N){
        Y[n] ~ normal(W * X[n] + V * Z[n] + mu, s2_model);
    }

}
