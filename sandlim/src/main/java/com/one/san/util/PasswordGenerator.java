package com.one.san.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class PasswordGenerator {
    public static void main(String[] args) {
        int passwordLength = 20;
        String password = generatePassword(passwordLength);
        System.out.println("Generated Password: " + password);
    }

    private static String generatePassword(int length) {
        String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
        String upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String digits = "0123456789";
        String specialCharacters = "!@#$%^&*()-+";
        String allCharacters = lowerCaseLetters + upperCaseLetters + digits + specialCharacters;

        Random random = new Random();
        List<Character> password = new ArrayList<>();

        password.add(lowerCaseLetters.charAt(random.nextInt(lowerCaseLetters.length())));
        password.add(upperCaseLetters.charAt(random.nextInt(upperCaseLetters.length())));
        password.add(digits.charAt(random.nextInt(digits.length())));
        password.add(specialCharacters.charAt(random.nextInt(specialCharacters.length())));

        for (int i = 4; i < length; i++) {
            password.add(allCharacters.charAt(random.nextInt(allCharacters.length())));
        }

        Collections.shuffle(password);

        StringBuilder passwordString = new StringBuilder();
        for (Character ch : password) {
            passwordString.append(ch);
        }

        return passwordString.toString();
    }
}