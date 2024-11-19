document.addEventListener("DOMContentLoaded", function(){
  // listen for auth status changes
  auth.onAuthStateChanged(user => {
   if (user) {
     console.log("user logged in");
     console.log(user);
     setupUI(user);
     var uid = user.uid;
     console.log(uid);
   } else {
     console.log("user logged out");
     setupUI();
   }
  });
  
  // login
  const loginForm = document.querySelector('#login-form');
  loginForm.addEventListener('submit', (e) => {
   e.preventDefault();
   // get user info
   const email = loginForm['input-email'].value;
   const password = loginForm['input-password'].value;
   // log the user in
   auth.signInWithEmailAndPassword(email, password).then((cred) => {
     // close the login modal & reset form
     loginForm.reset();
     console.log(email);
   })
   .catch((error) =>{
     const errorCode = error.code;
     const errorMessage = error.message;
     document.getElementById("error-message").innerHTML = errorMessage;
     console.log(errorMessage);
   });
  });
  
  // logout functionality for the logout button
  const logoutButton = document.querySelector('#logout-button');
  logoutButton.addEventListener('click', (e) => {
    e.preventDefault();
    auth.signOut().then(() => {
      console.log("User logged out");
      setupUI();  // Reset the UI after logout
    }).catch((error) => {
      console.error("Logout Error: ", error);
    });
  });
});
