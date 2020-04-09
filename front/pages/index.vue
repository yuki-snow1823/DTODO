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
        <v-icon class="mb-2" size="80">mdi-skull-outline</v-icon>
        <div><p>＊使い方を学んだら、さっさと戻ってTODOに取り掛かるんだな。<button>▼</button></p></div>
      </v-col>

      <v-col class="index-button-wrapper" v-else cols="12" sm="12" md="6" lg="6">
        <h2 id="index-signup" class="index-form-title text-center">新規登録はこちらから</h2>
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
        <v-hover v-slot:default="{ hover }">
          <v-btn class="index-button" @click="signup">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>
            sign up
          </v-btn>
        </v-hover>
      </v-col>
    </v-row>

    <v-row class="my-10">
      <v-col class="sub-introduction main" cols="12" sm="12" md="12" lg="12">
        <h1>やらなければならないことを楽しむ</h1>
        <h3 class="index-explain">毎日、何かやらなければならないTODOに追われていませんか？</h3>
        <h3 class="index-explain">めんどくさい、後回しにしたい、やりたくない…好きなことだけをしたい。</h3>
        <h3 class="index-explain">では、そのTODOすらも楽しいものに変えてみましょう！</h3>
        <h3 class="index-explain">DTODOがお手伝いします。</h3>
      </v-col>
    </v-row>

    <v-row class="introduction">

      <v-col class="sub-introduction" cols="12" sm="12" md="4" lg="4">
        <img class="" src="../assets/point.png">
        <h2 class="index-subtitle text-center">タスクポイントを設定しよう！</h2>
        <h3 class="index-explain">
          DTODOは日々のやらなければならないこと「TODO」を作成する時に、にタスクポイント（TP）を設定することができます。
          TPはご褒美の解放に使用できます。
        </h3>
      </v-col>

      <v-col class="sub-introduction" cols="12" sm="12" md="4" lg="4">
        <img src="../assets/point.png">
        <h2 class="index-subtitle text-center">レベルアップを目指そう！</h2>
        <h3 class="index-explain">
          TODOを完了するたびに経験値がたまります。より高いレベルを目指して頑張りましょう。
          レベルが高くなると、何かいいことが…？
        </h3>
      </v-col>

      <v-col class="sub-introduction" cols="12" sm="12" md="4" lg="4">
        <img src="../assets/point.png">
        <h2 class="index-subtitle text-center">自分にごほうびをあげよう！</h2>
        <h3 class="index-explain">
          DTODOを利用する際は、まずごほうびを作成しましょう。ご褒美の解放にはTPが必要です。
          たくさんのTODOをこなして、自分にごほうびをあげましょう。
        </h3>
      </v-col>
    </v-row>

    <v-row>
      <v-col class="index-button-wrapper" cols="12" sm="12" md="12" lg="12">
        <div class="mb-10››">
          <v-carousel height="100%">
            <v-carousel-item v-for="(item,i) in items" :key="i" :src="item.src" reverse-transition="fade-transition"
              transition="fade-transition"></v-carousel-item>
          </v-carousel>
        </div>
        <v-hover v-slot:default="{ hover }">
          <v-btn class="bottom-btn" @click.stop="dialog = true">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>ログイン
          </v-btn>
        </v-hover>
        
        <v-hover v-slot:default="{ hover }">
          <v-btn class="bottom-btn" v-on:click="moveToTop">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>新規登録
          </v-btn>
        </v-hover>
      </v-col>
    </v-row>

    <v-dialog content-class="dialog" v-model="dialog" max-width="60%">
      <v-card>
        <v-card-title class="headline">Login</v-card-title>
        <v-card-text>
          <form>
            <v-text-field v-model="email" :counter="20" label="email" data-vv-name="email" required></v-text-field>
            <v-text-field v-model="password" label="password" data-vv-name="password" required
              :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show1 = !show1"></v-text-field>
            <v-hover v-slot:default="{ hover }">
              <v-btn content-class="bottom-btn" @click="login">
                <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>ログイン
              </v-btn>
            </v-hover>
            <p v-if="error" class="errors">{{error}}</p>
          </form>
        </v-card-text>
      </v-card>
    </v-dialog>

  </v-container>
</template>

<script>
  import AddTodo from "@/components/AddTodo";
  import TodoList from "@/components/TodoList";
  import axios from "@/plugins/axios";
  import firebase from "@/plugins/firebase";
  import AssetsImage from "@/assets/point.png";
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
        dialog: false,
        items: [{
            // src: AssetsImage,
            src: 'https://cdn.vuetifyjs.com/images/carousel/sky.jpg',
          },
          {
            src: 'https://cdn.vuetifyjs.com/images/carousel/sky.jpg',
          }
        ],
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
      moveToTop() {
        const duration = 1000;
        const interval = 25;
        const step = -window.scrollY / Math.ceil(duration / interval);
        const timer = setInterval(() => {
          window.scrollBy(0, step);
          if (window.scrollY <= 0) {
            clearInterval(timer);
            const title = document.getElementById('index-signup');
            const check = function (name) {
              title.classList.add(name);
            }
            setTimeout(check, 1000, "checked");
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

  @mixin index-bottom-btn {
    background-color: black !important;
    border: 2px solid $main-color;
    color: $main-color;
    display: inline-block;
    margin: 15px;
    width: 45%;
    font-weight: bold;
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

    .index-subtitle, .index-form-title {
      @include explain
    }
    .index-explain {
      text-align: center;
      margin: 30px 0;
    }

    .index-button-wrapper {
      .index-button {
        background-color: black !important;
        border: 2px solid $main-color;
        color: $main-color;
        width: 100%;

        &:hover {
          border: 2px solid yellow;
          color: yellow;
        }
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
    .main {
      border: 1px white solid;
    }

    h1 {
      text-align: center;
      // color: $accent-color;
      margin: 30px 0;
    }

    .mdi-heart {
      color: red !important;
    }

    .checked {
      color: yellow
    }

    .index-button-wrapper {
      text-align: center;
      .bottom-btn {
        @include index-bottom-btn;

        &:hover {
          border: 2px solid yellow;
          color: yellow;
        }
      }
    }
    .dialog {
      .bottom-btn{
        @include index-bottom-btn;

        &:hover {
          border: 2px solid yellow;
          color: yellow;
        }
      }
    }
  }

  .v-window__container {
    border: solid 5px white;
  }
</style>
