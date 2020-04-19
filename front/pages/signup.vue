<template>
  <v-row class="signup-wrapper">
    <v-col cols="12" md="6">
      <h2 class="signup-title">Sign Up</h2>
      <form>
        <v-text-field v-model="name" :counter="10" label="Name" data-vv-name="name" required></v-text-field>
        <v-text-field v-model="email" :counter="20" label="Email" data-vv-name="email" required></v-text-field>
        <v-text-field v-model="password" label="password" data-vv-name="password" required
          :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"></v-text-field>
        <v-text-field v-model="passwordConfirm" label="passwordConfirm" data-vv-name="passwordConfirm" required
          :type="show2 ? 'text' : 'password'" :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show2 = !show2"></v-text-field>
        <v-hover v-slot:default="{ hover }">
          <v-btn class="bottom-btn" @click="signup">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>DETERMINATION
          </v-btn>
        </v-hover>
        <p v-if="error" class="errors">{{error}}</p>

      </form>
    </v-col>
  </v-row>
</template>

<script>
  import firebase from "@/plugins/firebase";
  import axios from "@/plugins/axios"
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
    },
    methods: {
      signup() {
        if (this.password !== this.passwordConfirm) {
          this.error = "パスワード確認が一致していません";
          return
        }
        if (this.name == "") {
          this.error = "名前を入力してください";
          return
        }
        firebase
          .auth()
          .createUserWithEmailAndPassword(this.email, this.password)
          .then(res => {
            const user = {
              email: res.user.email,
              name: this.name,
              uid: res.user.uid
            };
            this.$store.commit("setLoading", true);
            axios
              .post("/v1/users", {
                user
              })
              .then(res => {
                this.$store.commit("setLoading", false);
                this.$store.commit("setUser", res.data);
                this.$store.commit("setNotice", {
                  status: true,
                  message: "新規登録が完了しました"
                });
                setTimeout(() => {
                  this.$store.commit("setNotice", {});
                }, 2000);
                this.$router.push("/user");
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
                  return "パスワードは最低6文字以上にしてください";
                default:
                  return "メールアドレスとパスワードをご確認ください";
              }
            })(error.code);
          });
      },
    }
  };
</script>

<style lang="scss">
  $main-color: #fc7b03;
  $sub-color: #33dddd;

  @mixin index-bottom-btn {
    background-color: black !important;
    border: 2px solid $main-color;
    color: $main-color;
    display: inline-block;
    margin: 15px;
    width: 100%;
    font-weight: bold;
    margin-left: 0;
  }

  .signup-wrapper {

    .errors {
      color: red;
      margin-top: 20px;
    }

    .signup-title {
      color: $sub-color;
    }

    .bottom-btn {
      @include index-bottom-btn;

      &:hover {
        border: 2px solid yellow;
        color: yellow;
      }
    }

    .mdi-heart {
      color: red !important;
    }
  }
</style>
