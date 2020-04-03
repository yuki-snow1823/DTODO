<template>
  <v-row>
    <v-col cols="12" md="4">
      <h2>Sign Up</h2>
      <form>
        <v-text-field v-model="name" :counter="10" label="Name" 
        data-vv-name="name" required
        ></v-text-field>
        <v-text-field v-model="email" :counter="20" label="Email" 
        data-vv-name="email" required
        ></v-text-field>
        <v-text-field
          v-model="password"
          label="password"
          data-vv-name="password"
          required
          :type="show1 ? 'text' : 'password'"
          :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"
        ></v-text-field>
        <v-text-field
          v-model="passwordConfirm"
          label="passwordConfirm"
          data-vv-name="passwordConfirm"
          required
          :type="show2 ? 'text' : 'password'"
          :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show2 = !show2"
        ></v-text-field>
        <v-btn class="mr-4" @click="signup">submit</v-btn>
        <p v-if="error" class="errors">{{error}}</p>
      </form>
    </v-col>
  </v-row>
</template>

<script>
import firebase from "@/plugins/firebase";
import axios from "@/plugins/axios" //追加
export default {
  data() {
    return {
      email: "",
      name: "",
      password: "",
      passwordConfirm: "",
      show1: false,
      show2: false,
      error: ""
    };
    // 初期値
  },
methods: {
   signup() {
      if (this.password !== this.passwordConfirm) {
        this.error = "※パスワードとパスワード確認が一致していません";
      }

      this.$store.commit("setLoading", true);　//ローディングをonにする
      firebase
        .auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then(res => {
          const user = {
            email: res.user.email,
            name: this.name,
            uid: res.user.uid
          };
          axios.post("/v1/users", { user }).then(res => {　//追加
            this.$store.commit("setLoading", false);　//ローディングをoffにする
            this.$store.commit("setUser", res.data); //promiseの値をstoreに入れる
            this.$router.push("/");
          });
        })
        .catch(error => {
          this.error = (code => {
            switch (code) {
              case "auth/email-already-in-use":
                return "既にそのメールアドレスは使われています";
              case "auth/wrong-password":
                return "※パスワードが正しくありません";
              case "auth/weak-password":
                return "※パスワードは最低6文字以上にしてください";
              default:
                return "※メールアドレスとパスワードをご確認ください";
            }
          })(error.code);
        });
    }
  }
};
</script>

<style scoped>
.errors {
  color: red;
  margin-top: 20px;
}
</style>
