package util;

public class GeneratePassword {

    public static void main(String[] args) {

        String hash = BCryptUtil.hashPassword("faculty");

        System.out.println("Generated Hash:");
        System.out.println(hash);
    }
}
