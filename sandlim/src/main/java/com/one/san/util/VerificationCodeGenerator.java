package com.one.san.util;

import java.util.Random;

public class VerificationCodeGenerator {

    private static final int CODE_LENGTH = 6;
    private static final Random RANDOM = new Random();

    public static String generate() {
        StringBuilder code = new StringBuilder(CODE_LENGTH);

        for (int i = 0; i < CODE_LENGTH; i++) {
            code.append(RANDOM.nextInt(10));  // 0 ~ 9 사이의 랜덤한 숫자를 추가
        }

        return code.toString();
    }
}
