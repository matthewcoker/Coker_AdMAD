package com.example.lab8_amad;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

public class MainActivity extends AppCompatActivity {

    EditText emailID, password;
    Button signUpButton;
    TextView signInTV;
    FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mAuth = FirebaseAuth.getInstance();
        emailID = findViewById(R.id.emailText);
        password = findViewById(R.id.passwordText);
        signUpButton = findViewById(R.id.signUpButton);
        signInTV = findViewById(R.id.signInSwitchTV);
        signUpButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v){
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
                    Toast.makeText(MainActivity.this, "Fields are empty", Toast.LENGTH_SHORT).show();
                }
                else if (!(email.isEmpty() && pass.isEmpty())){
                    mAuth.createUserWithEmailAndPassword(email, pass).addOnCompleteListener(MainActivity.this, new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if (!task.isSuccessful()){
                                Toast.makeText(MainActivity.this, "Sign Up Failed", Toast.LENGTH_SHORT).show();
                            }
                            else {
                                startActivity(new Intent(MainActivity.this, Home.class));
                            }
                        }
                    });
                }
                else {
                    Toast.makeText(MainActivity.this, "Error: Ruh Roh", Toast.LENGTH_SHORT).show();
                }
            }
        });

        signInTV.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                Intent i = new Intent(MainActivity.this, Login.class);
                startActivity(i);
            }

        });

    }
}
