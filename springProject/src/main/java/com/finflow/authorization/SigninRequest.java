package com.finflow.authorization;

import lombok.Data;

@Data
public class SigninRequest {
    private String username;
    private String password;
}
