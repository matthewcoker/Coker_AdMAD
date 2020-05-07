package com.example.lab8_amad;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class Login extends AppCompatActivity {

    EditText emailID, password;
    Button signInButton;
    TextView signUpTV;
    FirebaseAuth mAuth;
    private FirebaseAuth.AuthStateListener mAuthStateListener;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        mAuth = FirebaseAuth.getInstance();
        emailID = findViewById(R.id.editText);
        password = findViewById(R.id.editText2);
        signInButton = findViewById(R.id.button);
        signUpTV = findViewById(R.id.textView);

        mAuthStateListener = new FirebaseAuth.AuthStateListener() {
            @Override
            public void onAuthStateChanged(@NonNull FirebaseAuth firebaseAuth) {
                FirebaseUser mFirebaseUser = mAuth.getCurrentUser();
                if (mFirebaseUser != null) {
                    Toast.makeText(Login.this, "Logged in", Toast.LENGTH_SHORT).show();
                    Intent i = new Intent(Login.this, Home.class);
                    startActivity(i);
                } else {
                    Toast.makeText(Login.this, "Please login", Toast.LENGTH_SHORT).show();
                }
            }
        };
        signInButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {

                String email = emailID.getText().toString();
                String pass = password.getText().toString();
                if (email.isEmpty()){
                    emailID.setError("Enter an email");
                    emailID.requestFocus();
                }
                else if (pass.isEmpty()){
                    password.setError("Enter your password");
                    password.requestFocus();
                }
                else if (email.isEmpty() && pass.isEmpty()){
                    Toast.makeText(Login.this, "Fields are empty", Toast.LENGTH_SHORT).show();
                }
                else if (!email.isEmpty() && pass.isEmpty()) {
                    mAuth.signInWithEmailAndPassword(email, pass).addOnCompleteListener(Login.this, new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if (!task.isSuccessful()) {
                                Toast.makeText(Login.this, "Login Error", Toast.LENGTH_SHORT).show();
                            } else {
                                Intent intToHome = new Intent(Login.this, Home.class);
                                startActivity(intToHome);
                            }
                        }
                    });
                }
                else {
                    Toast.makeText(Login.this, "Error: Ruh Roh", Toast.LENGTH_SHORT).show();
                }
            }
        });

        signUpTV.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View V) {
                Intent intSignUp = new Intent(Login.this, MainActivity.class);
                startActivity(intSignUp);
            }
        });
    }

    @Override
    protected void onStart(){
        super.onStart();
        mAuth.addAuthStateListener(mAuthStateListener);
    }
}