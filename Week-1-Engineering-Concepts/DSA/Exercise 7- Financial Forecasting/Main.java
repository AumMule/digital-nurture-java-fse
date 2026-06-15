public class Main {

    public static void main(String[] args) {

        double initialAmount = 5000;
        double growthRate = 0.05;
        int years = 2;

        double futureValue =
                FinancialForecast.predictFutureValue(
                        initialAmount,
                        growthRate,
                        years
                );

        System.out.println("Initial Amount : " + initialAmount);
        System.out.println("Growth Rate    : " + (growthRate * 100) + "%");
        System.out.println("Years          : " + years);
        System.out.println("Future Value   : " + futureValue);
    }
}