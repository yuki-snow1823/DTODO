import firebase from "@/plugins/firebase"

const actions = {
  login({
    commit,
  }, payload) {
    firebase
      .auth()
      .signInWithEmailAndPassword(payload.email, payload.password)
      .then(() => {
        commit("setNotice", {
          status: true,
          message: "ログインしました"
        });
        setTimeout(() => {
          commit("setNotice", {});
        }, 2000);
        this.$router.push("/user");
      })
      .catch(error => {
        console.log(error);
        this.error = (code => {
          switch (code) {
            case "auth/user-not-found":
              return "メールアドレスが間違っています";
            case "auth/wrong-password":
              return "※パスワードが正しくありません";
            default:
              return "※メールアドレスとパスワードをご確認ください";
          }
        })(error.code);
      });
  }
}
export default actions;
