<template>
  <v-container class="index-page">

    <h1 class="index-title"><span class="index-title-first">D</span>TODO</h1>

    <v-row>
      <v-col cols="12" sm="12" md="6" lg="6">
        <h2 class="index-subtitle text-center">DTODOとは</h2>
        <h3 class="index-explain">
          TODOに「タスクポイント」を設定し、日々こなすことであなたのレベルアップを手助けするアプリケーションです。
        </h3>
      </v-col>

      <v-col v-if="user" cols="12" sm="12" md="6" lg="6">
        <p>ログインしている人にはフォームは見えません</p>
      </v-col>

      <v-col class="index-button-wrapper" v-else cols="12" sm="12" md="6" lg="6">
        <h2 class="index-form-title text-center">新規登録はこちらから</h2>
        <form>
          <v-text-field v-model="name" :counter="10" label="Name" data-vv-name="name" required></v-text-field>
          <v-text-field v-model="email" :counter="20" label="Email" data-vv-name="email" required></v-text-field>
          <v-text-field v-model="password" label="password" data-vv-name="password" required
            :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show1"></v-text-field>
          <v-text-field v-model="passwordConfirm" label="passwordConfirm" data-vv-name="passwordConfirm" required
            :type="show2 ? 'text' : 'password'" :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show2 = !show2"></v-text-field>


          <p v-if="error" class="errors">{{error}}</p>
        </form>
        <v-btn class="index-button" @click="signup">Sigin up</v-btn>
      </v-col>
    </v-row>

    <v-row class="my-10">
      <v-col class="sub-introduction" cols="12" sm="12" md="12" lg="12">
        <h1>やらなければならないことを楽しむ</h1>
        <h3>毎日のタスクを</h3>

      </v-col>
    </v-row>

    <v-row class="introduction">

      <v-col class="sub-introduction" cols="12" sm="12" md="4" lg="4">
        <img class="" src="../assets/point.png">
        <h3 class="index-subtitle">タスクポイントを設定しよう！</h3>
        <p>
          DTODOは日々のやらなければならないこと「TODO」を作成する時に、にタスクポイント（TP）を設定することができます。
          TPはごほうびの解放に使用できます。難しいTPほどより高いタスクポイントを設定しましょう。
        </p>
      </v-col>

      <v-col class="sub-introduction" cols="12" sm="12" md="4" lg="4">
        <img src="../assets/point.png">
        <h3 class="index-subtitle">レベルアップを目指そう！</h3>
        <p>
          TODOを完了するたびに経験値がたまります。より高いレベルを目指して頑張りましょう。
          レベルが高くなると、何かいいことが…？
        </p>
      </v-col>

      <v-col class="sub-introduction" cols="12" sm="12" md="4" lg="4">
        <img src="../assets/point.png">
        <h3 class="index-subtitle">自分にごほうびをあげよう！</h3>
        <p>
          DTODOを利用する際は、まずごほうびを作成しましょう。作成の際には、ごほうびの解放に必要なTPを設定することができます。
          TODOをたくさん完了してTPが貯まったら、ご褒美を解放することができます。（TPは消費されます。）
        </p>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="8" sm="8" md="8" lg="8" offset="2">
        <v-carousel>
          <v-carousel-item v-for="(item,i) in items" :key="i" :src="item.src" reverse-transition="fade-transition"
            transition="fade-transition"></v-carousel-item>
        </v-carousel>
      </v-col>
    </v-row>

    <v-row>
      <div id="app">
        <v-btn v-on:click="openModal">ログイン</v-btn>
        <v-btn v-on:click="moveToTop">新規登録</v-btn>
        <div id="overlay" v-show="showContent">
          <div id="content">
            <v-row>
              <v-col cols="12" md="12">
                <h2>Login</h2>
                <form>
                  <v-text-field v-model="email" :counter="20" label="email" data-vv-name="email" required>
                  </v-text-field>
                  <v-text-field v-model="password" label="password" data-vv-name="password" required
                    :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                    @click:append="show1 = !show1"></v-text-field>
                  <v-btn class="mr-4 px-7" color="#f5851d" @click="login">LOCK!</v-btn>
                  <v-icon color="red">mdi-heart</v-icon>
                  <p v-if="error" class="errors">{{error}}</p>
                </form>
              </v-col>
            </v-row>
            <button v-on:click="closeModal">Back</button>
          </div>
        </div>
      </div>
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
        items: ["画像1", "画像2"],
        showContent: false
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
        //追加
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
      moveToTop() {
        const duration = 1000;
        const interval = 25;
        const step = -window.scrollY / Math.ceil(duration / interval);
        const timer = setInterval(() => {
          window.scrollBy(0, step);
          if (window.scrollY <= 0) {
            clearInterval(timer);
          }
        }, interval);
      }
    }
  };
</script>

<style lang="scss">
  $main-color: #fc7b03;
  $sub-color: #33dddd;
  $accent-color: #f0353f;

  @mixin explain {
    color: $sub-color;
    font-family: 'ヒラギノ角ゴシック';
    margin-bottom: 10px;
  }

  .index-page {

    .index-title {
      text-align: center;
      font-size: 70px;
      font-family: 'Comic Sans MS';

      .index-title-first {
        color: $main-color;
      }
    }
    .index-subtitle {
      @include explain
    }
    .index-form-title {
      @include explain
    }
    .index-explain {
      text-align: center;
      margin-bottom: 30px;
    }
    .index-button-wrapper {
      .index-button {
        background-color: black !important;
        border: 2px solid $main-color;
        color: $main-color;
        width: 100%;
      }
    }
    .introduction {

      img {
        width: 50%;
        height: 50%;
        display: block;
        margin: 0 auto 30px;
      }
      .sub-introduction {
        text-align: center;
      }
    }
    h1 {
      text-align: center;
      margin-top: 30px;
    }
    p {
      text-align: center;
    }
  }
















  .v-img {
    text-align: center;
  }

  .v-window__container {
    border: solid 5px white;
  }

  #overlay {
    z-index: 1;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 30, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
  }

</style>
