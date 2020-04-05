<template>
  <v-container>
    <div v-if="user">
      <p>お名前：{{user.name}}</p>
      <!-- <p>{{user.id}}</p> -->
      <AddTodo @submit="addTodo" />
      <TodoList :todos="user.todos" />
    </div>

    <div v-else>
      <h1 id="title" class="text-center">DTODO</h1>
      <v-row>
        <v-col cols="12" sm="12" md="6" lg="6">
          <h2 class="mb-3 text-center">タスク管理をゲームに！</h2>
          <h3>これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。
            これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介</h3>
        </v-col>
        <v-col cols="12" sm="12" md="6" lg="6">
          <!-- サインアップフォームはここ -->
          <form>
            <h2 class="text-center">新規登録はコチラ</h2>
            <v-text-field v-model="name" :counter="10" label="Name" data-vv-name="name" required></v-text-field>
            <v-text-field v-model="email" :counter="20" label="Email" data-vv-name="email" required></v-text-field>
            <v-text-field v-model="password" label="password" data-vv-name="password" required
              :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show1 = !show1"></v-text-field>
            <v-text-field v-model="passwordConfirm" label="passwordConfirm" data-vv-name="passwordConfirm" required
              :type="show2 ? 'text' : 'password'" :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show2 = !show2"></v-text-field>
            <v-btn class="mr-4" @click="signup">submit</v-btn>
            <!-- 押したらサインアップメソッドにいく -->
            <p v-if="error" class="errors">{{error}}</p>
          </form>
        </v-col>
      </v-row>

      <v-row class="introduction">
        <v-col cols="12" sm="12" md="4" lg="4">
          <v-img width="50%" height="50%"
            src="https://4.bp.blogspot.com/-PDD_C43ZQ9A/V5AXrn_GD6I/AAAAAAAA8Z4/0KzHBvARnV4itcdlfhCpbtPSTwHYqPzcgCLcB/s800/vr_game_pad.png">
          </v-img>
          <h3>特徴の１つめです</h3>
          <p>説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
            説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
          </p>
        </v-col>
        <v-col cols="12" sm="12" md="4" lg="4">
          <v-img width="50%" height="50%"
            src="https://4.bp.blogspot.com/-PDD_C43ZQ9A/V5AXrn_GD6I/AAAAAAAA8Z4/0KzHBvARnV4itcdlfhCpbtPSTwHYqPzcgCLcB/s800/vr_game_pad.png">
          </v-img>
          <h3>特徴の１つめです</h3>
          <p>説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
            説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
          </p>
        </v-col>
        <v-col cols="12" sm="12" md="4" lg="4">
          <v-img width="50%" height="50%"
            src="https://4.bp.blogspot.com/-PDD_C43ZQ9A/V5AXrn_GD6I/AAAAAAAA8Z4/0KzHBvARnV4itcdlfhCpbtPSTwHYqPzcgCLcB/s800/vr_game_pad.png">
          </v-img>

          <h3>特徴の１つめです</h3>
          <p>説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
            説明文です。説明文です。説明文です。説明文です。説明文です。説明文です。
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
        <!-- モータルウィンドウ -->
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
    </div>

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
        password: "",
        passwordConfirm: "",
        show1: false,
        show2: false,
        error: "",
        items: ["画像1", "画像2"],
        showContent: false
      };
      // ログインに必要な初期値
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
    // ナビゲーションガード（監視）
    components: {
      AddTodo,
      TodoList
    },
    // ログイン時のくるくるをいれたい
    computed: {
      user() {
        return this.$store.state.currentUser;
      }
      // カレントユーザーの定義
    },
    methods: {
      async addTodo(todo) {
        // 子から送られてきたtodoを持っている
        const {
          data
        } = await axios.post("/v1/todos", {
          todo
        });
        //追加
        this.$store.commit("setUser", {
          ...this.user,
          todos: [...this.user.todos, data]
          // 初期値ではなくpostできるように
        });
      },
      signup() {
        if (this.password !== this.passwordConfirm) {
          this.error = "※パスワードとパスワード確認が一致していません";
        }
        this.$store.commit("setLoading", false); //ローディングをonにする、一旦falseにした
        firebase
          .auth()
          .createUserWithEmailAndPassword(this.email, this.password)
          .then(res => {
            const user = {
              email: res.user.email,
              name: this.name,
              uid: res.user.uid
            };
            axios.post("/v1/users", {
              user
            }).then(res => { //追加
              this.$store.commit("setLoading", false); //ローディングをoffにする、ここで本来オフになる
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
      },
      login() {
        this.$store.dispatch("login", {
          email: this.email,
          password: this.password
        });
      },
      openModal: function () {
        this.showContent = true
      },
      closeModal: function () {
        this.showContent = false
      },
      moveToTop() {

        const duration = 1000; // 移動速度（1秒で終了）
        const interval = 25; // 0.025秒ごとに移動
        const step = -window.scrollY / Math.ceil(duration / interval); // 1回に移動する距離
        const timer = setInterval(() => {

          window.scrollBy(0, step); // スクロール位置を移動

          if (window.scrollY <= 0) {

            clearInterval(timer);
            // 動ききった後に新規登録をハイライトさせたい。
          }

        }, interval);

      }
    }
  };
</script>

<style>
  #title {
    display: inline-block;
    background-color: #fc7b03;
    text-align: center;
    margin: 0 auto;
  }

  .introduction {
    margin-top: 50px;
  }

  .introduction h3 {
    text-align: center;
    margin: 0 auto;
    color: aqua !important;
  }

  /* 指定がうまくいかない */
  .v-img {
    text-align: center;
  }

  .v-window__container {
    border: solid 5px white;
  }


  /* モータルウィンドウ */
  #overlay {
    /*　要素を重ねた時の順番　*/
    z-index: 1;

    /*　画面全体を覆う設定　*/
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 30, 0.5);

    /*　画面の中央に要素を表示させる設定　*/
    display: flex;
    align-items: center;
    justify-content: center;
  }


</style>
