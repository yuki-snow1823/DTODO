<template>
  <v-container class="user-page" v-if="user">
    <v-row justify="center">
      <v-col class="user-status" cols="12" xs="6" sm="8" md="10" lg="7">
        <v-row>
        <v-col cols="12" xs="6" sm="8" md="10" lg="6">
            <h2>ステータス</h2>
            <p>お名前：{{user.name}}</p>
            <p>レベル：{{user.level}}</p>
            <p>経験値：{{user.experience_point}}</p>
            <p>TP：{{user.point}}</p>
        </v-col>
        <v-col cols="12" xs="6" sm="8" md="5" lg="6">
          <p>右半分</p>
          <router-link to="/reward">ご褒美ページへ</router-link>
        </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import AddTodo from "@/components/AddTodo";
  import TodoList from "@/components/TodoList";
  import axios from "@/plugins/axios";
  import firebase from "@/plugins/firebase";
  export default {
    data() {
      return {
        email: "",
        name: "",
        level: "",
        point: "",
        experience_point: "",
        password: "",
        passwordConfirm: "",
        show1: false,
        show2: false,
        error: "",
      };
    },
    fetch({
      store,
      redirect
    }) {
      store.watch(
        state => state.currentUser,
        (newUser, oldUser) => {
          if (!newUser) {
            return redirect("/login");
          }
        }
      );
    },
    components: {
      AddTodo,
      TodoList
    },
    computed: {
      user() {
        return this.$store.state.currentUser;
      },
    },
    methods: {
      async addTodo(todo) {
        const {
          data
        } = await axios.post("/v1/todos", {
          todo
        });
        this.$store.commit("setUser", {
          ...this.user,
          todos: [...this.user.todos, data]
        });
      },
      signup() {
        if (this.password !== this.passwordConfirm) {
          this.error = "※パスワードとパスワード確認が一致していません";
        }
        this.$store.commit("setLoading", true);
        firebase
          .auth()
          .createUserWithEmailAndPassword(this.email, this.password)
          .then(res => {
            const user = {
              email: res.user.email,
              name: this.name,
              uid: res.user.uid
            };
            axios
              .post("/v1/users", {
                user
              })
              .then(res => {
                this.$store.commit("setLoading", false);
                this.$store.commit("setUser", res.data);
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
                  return "※パスワードは最低6文字以上にしてください";
                default:
                  return "※メールアドレスとパスワードをご確認ください";
              }
            })(error.code);
          });
      },
      login() {
        this.$store.dispatch("login", {
          email: this.email,
          password: this.password
        });
      },
      openModal: function () {
        this.showContent = true;
      },
      closeModal: function () {
        this.showContent = false;
      },
    }
  };
</script>

<style lang="scss">
  .user-page {
    .user-status {
      border: 2px white solid;
      // display: inline-block;
    }
  }

</style>
