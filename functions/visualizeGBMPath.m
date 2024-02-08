function visualizeGBMPath(path, theta, dt)
    % Number of steps
    numSteps = length(path);

    % Create a time vector for the x-axis
    timeVector = 0:dt:(numSteps-1)*dt;

    % Create the plot
    figure;
    plot(timeVector, path, 'LineWidth', 2);
    hold on;

    % Highlight the long-term mean
    yline(theta, 'r--', 'LineWidth', 1.5);

    % Labels and title
    title('Mean-Reverting GBM Path');
    xlabel('Time');
    ylabel('GBM Value');

    % Legend
    legend('GBM Path', 'Long-Term Mean');

    hold off;
end
