public class FinancialForecast {

    public static double predictFutureValue(double initialAmount,
                                            double growthRate,
                                            int years) {

        // Base Case
        if (years == 0) {
            return initialAmount;
        }

        // Recursive Case
        return predictFutureValue(initialAmount,
                growthRate,
                years - 1) * (1 + growthRate);
    }
}