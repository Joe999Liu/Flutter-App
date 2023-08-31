package com.emercy.myapplication;

import android.text.TextUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Emercy
 * @description
 * @data 2022/6/15
 */
public class FindPDF {

    private static final String PDF_SUFFIX = ".pdf";

    public static List<File> findPdf(String path, Condition condition) {
        List<File> result = new ArrayList<>();
        List<File> directory = new ArrayList<>();

        if (TextUtils.isEmpty(path)) {
            return result;
        }

        File file = new File(path);
        if (!file.exists()) {
            return result;
        }
        File[] files = file.listFiles();
        if (files == null) {
            return result;
        }

        for (File f : files) {
            if (f.isDirectory()) {
                directory.add(f);
            } else if (condition.checkCondition(f)) {
                result.add(f);
            }
        }
        for (File f : directory) {
            result.addAll(findPdf(f.getAbsolutePath(), condition));
        }
        return result;
    }
}

interface Condition {
    public boolean checkCondition(File file);
}

class Main {
    public static void main() {
        FindPDF.findPdf("/root", file -> file.getSize > 100);
    }
}