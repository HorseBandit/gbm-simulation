function interactiveGBMVisualization()
    kappa = 0.5; theta = 100; sigma = 0.1; dt = 0.01; T = 1; X0 = 100;
    numSteps = T/dt;
    timeVector = 0:dt:(numSteps-1)*dt; 
    figure;
    
    % Subplot for the GBM Path
    axPath = subplot(2,1,1);
    
    % Initial plot setup
    path = generateElectricityPricePath(kappa, theta, sigma, dt, numSteps, X0);
    plot(axPath, (0:numSteps-1)*dt, path, 'LineWidth', 2);
    hold(axPath, 'on');
    yline(axPath, theta, 'r--', 'LineWidth', 1.5);
    hold(axPath, 'off');
    
    % Enhancing the plot with titles and labels
    title(axPath, 'Mean-Reverting GBM Path for Simulated Electricity Prices');
    xlabel(axPath, 'Time');
    ylabel(axPath, 'Price');
    legend(axPath, 'Simulated Price Path', 'Long-Term Mean (Theta)');
    
    % Subplot for parameter controls
    axControls = subplot(2,1,2);
    title(axControls, 'Adjust Parameters');
    set(axControls, 'Visible', 'off');

    % Kappa Slider and Value Display
    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.1 0.45 0.2 0.05], 'String', 'Kappa (Reversion Rate)');
    sliderKappa = uicontrol('Style', 'slider', 'Min',0, 'Max',1, 'Value',kappa, 'Units', 'normalized', 'Position', [0.1 0.4 0.3 0.05], 'Callback', @(src, event) updatePlot());
    kappaValueText = uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.45 0.4 0.1 0.05], 'String', num2str(kappa));

    % Theta Slider and Value Display
    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.1 0.35 0.2 0.05], 'String', 'Theta (Long-term Mean)');
    sliderTheta = uicontrol('Style', 'slider', 'Min',50, 'Max',150, 'Value',theta, 'Units', 'normalized', 'Position', [0.1 0.3 0.3 0.05], 'Callback', @(src, event) updatePlot());
    thetaValueText = uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.45 0.3 0.1 0.05], 'String', num2str(theta, '%.2f'));
    
    % Sigma Slider and Value Display
    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.1 0.25 0.2 0.05], 'String', 'Sigma (Volatility)');
    sliderSigma = uicontrol('Style', 'slider', 'Min',0, 'Max',0.5, 'Value',sigma, 'Units', 'normalized', 'Position', [0.1 0.2 0.3 0.05], 'Callback', @(src, event) updatePlot());
    sigmaValueText = uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.45 0.2 0.1 0.05], 'String', num2str(sigma, '%.2f'));

    % ... [Rest of your existing code for sliders]

   % Slider for kappa
    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.1 0.45 0.2 0.05], 'String', 'Kappa (Reversion Rate)');
    sliderKappa = uicontrol('Style', 'slider', 'Min',0,'Max',1,'Value',kappa, 'Units', 'normalized', 'Position', [0.1 0.4 0.3 0.05], 'Callback', @(src, event) updatePlot());
    
    % Slider for theta
    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.1 0.35 0.2 0.05], 'String', 'Theta (Long-term Mean)');
    sliderTheta = uicontrol('Style', 'slider', 'Min',50,'Max',150,'Value',theta, 'Units', 'normalized', 'Position', [0.1 0.3 0.3 0.05], 'Callback', @(src, event) updatePlot());
    
    % Slider for sigma
    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.1 0.25 0.2 0.05], 'String', 'Sigma (Volatility)');
    sliderSigma = uicontrol('Style', 'slider', 'Min',0,'Max',0.5,'Value',sigma, 'Units', 'normalized', 'Position', [0.1 0.2 0.3 0.05], 'Callback', @(src, event) updatePlot());


    % Play/Pause Button Setup
    isPlaying = false;
    btnPlay = uicontrol('Style', 'pushbutton', 'String', 'Play', 'Units', 'normalized', 'Position', [0.6 0.1 0.1 0.05], 'Callback', @(src, event) playAnimation());
    btnPause = uicontrol('Style', 'pushbutton', 'String', 'Pause', 'Units', 'normalized', 'Position', [0.7 0.1 0.1 0.05], 'Callback', @(src, event) pauseAnimation());

    % Animation Function
    function playAnimation()
        isPlaying = true;
        set(btnPlay, 'Enable', 'off');
        set(btnPause, 'Enable', 'on');
        for t = 1:numSteps
            if ~isPlaying
                break;
            end
            % Update plot for each time step
            set(axPath, 'XLim', [0 t*dt]);
            drawnow; % Update the plot
            pause(0.05); % Control the speed of animation
        end
        set(btnPlay, 'Enable', 'on');
        set(btnPause, 'Enable', 'off');
    end

    function pauseAnimation()
        isPlaying = false;
        set(btnPause, 'Enable', 'off');
        set(btnPlay, 'Enable', 'on');
    end


    % Initial plot
    path = generateElectricityPricePath(kappa, theta, sigma, dt, numSteps, X0);
    plot(axPath, (0:numSteps-1)*dt, path);
    hold(axPath, 'on');
    yline(axPath, theta, 'r--', 'LineWidth', 1.5);
    hold(axPath, 'off');

    % Update function for updating the plot
    function updatePlot()
        % Update parameters based on slider values
        kappa = get(sliderKappa, 'Value');
        theta = get(sliderTheta, 'Value');
        sigma = get(sliderSigma, 'Value');

         % Update the text displays with current parameter values
        set(kappaValueText, 'String', num2str(kappa, '%.2f'));
        set(thetaValueText, 'String', num2str(theta, '%.2f'));
        set(sigmaValueText, 'String', num2str(sigma, '%.2f'));
    
        % Generate the main GBM path
        path = generateElectricityPricePath(kappa, theta, sigma, dt, numSteps, X0);
    
        % Generate multiple paths for the forecast cone
        numPaths = 100;
        allPaths = zeros(numPaths, numSteps);
        for p = 1:numPaths
            allPaths(p, :) = generateElectricityPricePath(kappa, theta, sigma, dt, numSteps, X0);
        end
    
        % Calculate quantiles for the forecast cone
        lowerQuantile = quantile(allPaths, 0.05);
        upperQuantile = quantile(allPaths, 0.95);
    
        % Clearing and updating the plot
        cla(axPath);
        hold(axPath, 'on');
    
        % Plotting the forecast cone first
        fill(axPath, [timeVector, fliplr(timeVector)], [lowerQuantile, fliplr(upperQuantile)], 'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none');
    
        % Plotting the main GBM path
        plot(axPath, timeVector, path, 'LineWidth', 2);
    
        % Plotting the long-term mean line
        yline(axPath, theta, 'r--', 'LineWidth', 1.5);
    
        % Setting legend in the order of plotting
        legend(axPath, 'Forecast Cone', 'Simulated Price Path', 'Long-Term Mean (Theta)');
    
        % Re-apply labels and title
        title(axPath, 'Mean-Reverting GBM Path for Simulated Electricity Prices');
        xlabel(axPath, 'Time');
        ylabel(axPath, 'Price');
    
        hold(axPath, 'off');
    end
    updatePlot();
end

