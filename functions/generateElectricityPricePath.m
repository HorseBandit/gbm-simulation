function pricePath = generateElectricityPricePath(kappa, theta, sigma, dt, numSteps, X0)
    % Initialize the price path
    pricePath = zeros(1, numSteps);
    pricePath(1) = X0;

    % Generate the price path
    for i = 2:numSteps
        dW = sqrt(dt) * randn; % Wiener process increment
        % GBM formula for mean reversion, tailored for price simulation
        pricePath(i) = pricePath(i-1) + kappa * (theta - pricePath(i-1)) * dt + sigma * pricePath(i-1) * dW;
    end
end
