class SearchAlgorithms{
    //Linear Search

    public static int linearSearch(Product[] products , int productId){
        for(int i = 0; i < products.length; i++){
            if(products[i].getProductId() == productId){
                return i;
            }
        }
        return -1;
    }

    //Binary Search
    public static int binarySearch(Product[] products , int productId){
        int left = 0;
        int right = products.length - 1;

        while(left <= right){
            int mid = left + (right - left) / 2;

            if(products[mid].getProductId() == productId){
                return mid;
            } else if(products[mid].getProductId() < productId){
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1;
    }

}