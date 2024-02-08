function path = generateGBMPath(kappa, theta, sigma, dt, numSteps, X0)
    % Initialize the path array
    path = zeros(1, numSteps);
    path(1) = X0;

    % Generate the GBM path
    for i = 2:numSteps
        % Random sample for the Wiener process increment
        dW = sqrt(dt) * randn;
        
        % GBM formula for mean reversion
        path(i) = path(i-1) + kappa * (theta - path(i-1)) * dt + sigma * dW;
    end
end
