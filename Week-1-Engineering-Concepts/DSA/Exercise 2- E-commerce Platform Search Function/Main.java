public class Main {

    public static void main(String[] args) {

        Product[] products = {
                new Product(101, "iPhone", "Mobile"),
                new Product(102, "MacBook", "Laptop"),
                new Product(103, "Samsung S25", "Mobile"),
                new Product(104, "Dell XPS", "Laptop"),
                new Product(105, "Lenovo ThinkPad", "Laptop")
        };

        int targetId = 104;

        // Linear Search
        int linearResult = SearchAlgorithms.linearSearch(products, targetId);

        if (linearResult != -1) {
            System.out.println("Linear Search: Product found at index " + linearResult);
            System.out.println("Product Name: " + products[linearResult].getProductName());
        } else {
            System.out.println("Linear Search: Product not found");
        }

        System.out.println();

        // Binary Search
        int binaryResult = SearchAlgorithms.binarySearch(products, targetId);

        if (binaryResult != -1) {
            System.out.println("Binary Search: Product found at index " + binaryResult);
            System.out.println("Product Name: " + products[binaryResult].getProductName());
        } else {
            System.out.println("Binary Search: Product not found");
        }
    }
}