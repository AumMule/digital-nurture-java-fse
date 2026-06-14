class Singleton{
    private static Singleton instance = new Singleton();

    private Singleton() {
        System.out.println("Object Created");
    }

    

    public static Singleton getInstance() {
        return instance;
    }

}