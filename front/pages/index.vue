<template>
  <v-container class="index-page">

    <h1 v-if="countHiddenPage >= 5"><span>D</span>
      means<span>
        Determination</span>
      to become an engineer and to challenge <span>Vue.js!</span></h1>

    <h1 v-else class="index-title"><span class="index-title-first">D</span>TODO</h1>

    <v-row>
      <v-col cols="12" sm="12" md="6" lg="6">
        <h1 class="index-subtitle text-center">DTODOとは</h1>
        <h2 class="index-explain">
          TODOに「タスクポイント」を設定し、日々こなすことであなたのレベルアップを手助けするアプリケーションです。
        </h2>
        <div class="monster">
          <img class="mon" src="../assets/mon_284.gif" />
          <img class="mon" src="../assets/mon_199.gif" />
          <img class="mon" src="../assets/mon_100.gif" />
          <img class="mon" src="../assets/mon_091.gif" />
        </div>
        <div v-if="user"></div>
        <div class="guest" v-else>
          <v-hover v-slot:default="{ hover }">
            <v-btn class="guest-btn" @click="guestLogin">
              <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>ゲストログイン
            </v-btn>
          </v-hover>
          <p>※ゲストはログイン後、毎回チュートリアルが再生されます。</p>
          <p>1回だけでいい場合は新規登録をお願いします。</p>
        </div>
      </v-col>

      <v-col class="wrapper-skull" v-if="user" cols="12" sm="12" md="6" lg="6">
        <v-icon id="skull" :color="color" @click="countSkull()" class="mb-2 skull" :size="size">mdi-skull-outline
        </v-icon>
        <h1 v-if="countHiddenPage >= 15">押しすぎだ。</h1>
        <div class="instead-of-form">
          <vue-typer :text="[
              '＊俺が見えてるってことは',
              '＊ログインしているってことだ。',
              '＊わざわざログインしたまま\nトップ画面に来るなんて',
              '＊物好きだな。',
              '＊ところでアンタ\nこのアプリの「D」の意味は知っているか？',
              '＊フフフ・・・',
              '＊俺様の顔を５回クリックすると',
              '＊わかるかもな。',
              '＊スマホのやつは\n上にスライドしてくれよな。',
              '＊じゃあな。',
            ]" erase-style="clear" :type-delay="140" :erase-delay="270" :repeat="Infinity"></vue-typer>
        </div>
      </v-col>

      <v-col class="index-button-wrapper" v-else cols="12" sm="12" md="6" lg="6">
        <h1 id="index-signup" class="index-form-title text-center">
          新規登録はこちらから
        </h1>
        <form>
          <v-text-field v-model="name" :counter="10" label="Name" data-vv-name="name" required></v-text-field>
          <v-text-field v-model="email" :counter="30" label="Email" data-vv-name="email" required></v-text-field>
          <v-text-field v-model="password" label="password" data-vv-name="password" required
            :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show1"></v-text-field>
          <v-text-field v-model="passwordConfirm" label="passwordConfirm" data-vv-name="passwordConfirm" required
            :type="show2 ? 'text' : 'password'" :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show2 = !show2"></v-text-field>

          <p v-if="error" class="errors">{{ error }}</p>
        </form>
        <v-hover v-slot:default="{ hover }">
          <v-btn class="index-button" @click="signup">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>
            START
          </v-btn>
        </v-hover>
      </v-col>
    </v-row>

    <v-row class="introduction">
      <v-col class="main" cols="12" sm="12" md="12" lg="12">
        <h1>やらなければならないことを楽しむ</h1>
        <h2 class="index-explain">
          毎日、何かやらなければならないTODOに追われていませんか？
        </h2>
        <h2 class="index-explain">
          めんどくさい、後回しにしたい、やりたくない…好きなことだけをしたい。
        </h2>
        <h2 class="index-explain">
          では、そのTODOすらも楽しいものに変えてみましょう！
        </h2>
        <h2 class="index-explain">DTODOがお手伝いします。</h2>
      </v-col>
    </v-row>

    <v-row class="introduction mb-0 justify-center">
      <v-col class="sub-introduction mx-2 mb-2" v-scroll="handleScroll" cols="12" sm="12" md="4" lg="3">
        <img src="../assets/mon_259.gif" />
        <h2 class="index-subtitle text-center">タスクポイントを<br>設定しよう！</h2>
        <h3 class="index-explain">
          DTODOは日々のやらなければならないこと「TODO」を作成する時に、にタスクポイント（TP）を設定することができます。
          TPはご褒美の解放に使用できます。
        </h3>
      </v-col>

      <v-col class="sub-introduction mx-2 mb-2" v-scroll="handleScroll" cols="12" sm="12" md="4" lg="3">
        <img src="../assets/mon_237.gif" />
        <h2 class="index-subtitle text-center">レベルアップを<br>目指そう！</h2>
        <h3 class="index-explain">
          TODOを完了するたびに経験値がたまります。より高いレベルを目指して頑張りましょう。
          レベルが高くなると、何かいいことが…？
        </h3>
      </v-col>

      <v-col class="sub-introduction mx-2 mb-2" v-scroll="handleScroll" cols="12" sm="12" md="4" lg="3">
        <img class="pt-10" src="../assets/mon_278.gif" />
        <h2 class="index-subtitle text-center">自分にごほうびを<br>あげよう！</h2>
        <h3 class="index-explain">
          DTODOを利用する際は、まずごほうびを作成しましょう。ご褒美の解放にはTPが必要です。
          たくさんのTODOをこなして、自分にごほうびをあげましょう。
        </h3>
      </v-col>
    </v-row>

    <v-row>
      <v-col class="index-button-wrapper" cols="12" sm="12" md="12" lg="12">

        <v-hover v-slot:default="{ hover }">
          <div v-if="user"></div>
          <v-btn v-else class="bottom-btn" @click.stop="dialog = true">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>ログイン
          </v-btn>
        </v-hover>

        <v-hover v-slot:default="{ hover }">
          <div v-if="user"></div>
          <v-btn v-else class="bottom-btn" v-on:click="moveToTop">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>新規登録
          </v-btn>
        </v-hover>
      </v-col>
    </v-row>

    <v-dialog content-class="dialog" v-model="dialog" max-width="60%">
      <v-card>
        <v-card-title class="headline">
          <h3>Login</h3>
        </v-card-title>
        <v-card-text>
          <form>
            <v-text-field v-model="email" :counter="20" label="email" data-vv-name="email" required></v-text-field>
            <v-text-field v-model="password" label="password" data-vv-name="password" required
              :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show1 = !show1"></v-text-field>
            <v-hover v-slot:default="{ hover }">
              <v-btn class="dialog-btn" @click="login">
                <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>START
              </v-btn>
            </v-hover>
            <p v-if="error" class="errors">{{ error }}</p>
          </form>
        </v-card-text>
      </v-card>
    </v-dialog>

    <iframe class="how-to-use" src="https://www.youtube.com/embed/bg72-7woCI4?rel=0" frameborder="0"
      allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

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
        dialog: false,
        countHiddenPage: 0,
        color: "",
        size: 80,
        showContent: false
      };
    },
    components: {
      AddTodo,
      TodoList
    },
    computed: {
      user() {
        return this.$store.state.currentUser;
      }
    },
    methods: {
      signup() {
        if (this.password !== this.passwordConfirm) {
          this.error = "パスワード確認が一致していません";
          return;
        }
        if (this.name == "") {
          this.error = "名前を入力してください";
          return;
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
                let param = {
                  user: res.data
                };
                this.$store.commit("setUser", param);
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
      login() {
        firebase
          .auth()
          .signInWithEmailAndPassword(this.email, this.password)
          .then(() => {
            this.$store.commit("setLoading", true);
            this.$store.commit("setNotice", {
              status: true,
              message: "ログインに成功しました"
            });
            setTimeout(() => {
              this.$store.commit("setLoading", false);
            }, 3000);
            setTimeout(() => {
              this.$store.commit("setNotice", {});
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
      },
      guestLogin() {
        this.$store.commit("setLoading", true);
        firebase
          .auth()
          .signInWithEmailAndPassword("testtest777@gmail.com", "aaaaaa")
          .then(() => {
            this.$store.commit("setNotice", {
              status: true,
              message: "ログインに成功しました"
            });
            setTimeout(() => {
              this.$store.commit("setLoading", false);
            }, 1500);
            setTimeout(() => {
              this.$store.commit("setNotice", {});
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
      },
      moveToTop() {
        let element = document.getElementById("index-signup");
        element.scrollIntoView({
          behavior: "smooth",
          block: "center"
        });
        const title = document.getElementById("index-signup");
        const check = function (name) {
          title.classList.add(name);
        };
        setTimeout(check, 1000, "checked");
      },
      countSkull() {
        this.countHiddenPage++;
        this.size += 10;
        this.color = "green"
      },
      handleScroll: function (evt, el) {
        console.log(window.scrollY);
        if (window.scrollY > 50) {
          el.setAttribute(
            "style",
            "opacity: 1; transform: translate3d(0, -10px, 0)",
            "transform: translateY(0);"
          );
        }
        return window.scrollY > 100;
      }
    },
    created() {
      this.$vuetify.lang = {
        t: () => {}
      };
      //testを実行する際に直接関係ないエラーを回避する為に記述してあります。
    }
  };
</script>

<style lang="scss">
  $main-color: #fc7b03;
  $sub-color: #33dddd;
  $accent-color: #f0353f;

  @mixin explain {
    color: $sub-color;
    font-family: "ヒラギノ角ゴシック";
    margin-bottom: 10px;
  }

  @mixin index-bottom-btn {
    background-color: black !important;
    border: 2px solid $main-color;
    color: $main-color !important;
    display: inline-block;
    margin: 15px;
    width: 80%;
    font-weight: bold;
  }

  $pc: 1024px;
  $tab: 680px;
  $sp: 480px;

  // レスポンシブデザイン用の指定です。
  @mixin pc {
    @media (max-width: ($pc)) {
      @content;
    }
  }

  @mixin tab {
    @media (max-width: ($tab)) {
      @content;
    }
  }

  @mixin sp {
    @media (max-width: ($sp)) {
      @content;
    }
  }

  .index-page {
    .mon {
      width: 9%;

      @include sp {
        width: 20%;
      }
    }

    .monster {
      text-align: center;
    }

    .index-title {
      text-align: center;
      font-size: 70px;
      font-family: "Comic Sans MS";
      margin-bottom: 0px;
      color: white !important;

      .index-title-first {
        color: $main-color;
      }
    }

    .index-subtitle {
      color: rgb(32, 23, 23);
    }
    .index-form-title {
      @include explain;
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

    .skull {
      padding-left: 40%;
    }

    .instead-of-form {
      border: 2px white solid;
      padding: 20px 0;
      text-align: center;
    }

    .introduction {
      margin: 100px auto 50px;

      img {
        margin: 0 auto 30px;
        display: block;
      }

      .sub-introduction {
        text-align: center;
        opacity: 0;
        transition: 4s all cubic-bezier(0.39, 0.575, 0.565, 1);
        transform: translateY(-60px);
        background: #726a6a;
        border-radius: 240px 15px 100px 15px / 15px 200px 15px 185px;
      }
    }

    .main {
      border: 1px white solid;
    }

    h1 {
      text-align: center;
      margin: 30px 0;
    }

    .mdi-heart {
      color: red !important;
    }

    .checked {
      color: yellow;
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
      .bottom-btn {
        @include index-bottom-btn;

        &:hover {
          border: 2px solid yellow;
          color: yellow;
        }
      }
    }

    .errors {
      color: $accent-color;
    }
  }

  .dialog-btn {
    background-color: rgb(29, 29, 29) !important;
    border: 2px solid $main-color;
    color: $main-color !important;
    display: inline-block;
    margin: 15px;
    width: 45%;
    font-weight: bold;

    .mdi-heart {
      color: red !important;
    }

    &:hover {
      border: 2px solid yellow;
      color: yellow;
    }
  }

  .headline {
    color: $sub-color;
  }

  .guest {
    text-align: center;

    .guest-btn {
      @include index-bottom-btn;

      &:hover {
        border: 2px solid yellow;
        color: yellow !important;
      }

      @include sp {
        font-size: 25px;
        width: 80% !important;
        height: 70px !important;
      }
    }
  }

  .vue-typer {
    font-family: monospace;
    font-size: 20px;
  }

  .vue-typer .custom.char {
    color: #d4d4bd;
    background-color: #1e1e1e;
  }

  .vue-typer .custom.char.selected {
    background-color: #264f78;
  }

  .vue-typer .custom.caret {
    width: 10px;
    background-color: #3f51b5;
  }

  .green {
    color: green;
  }

  .wrapper-skull {
    margin: 0 auto;

    #skull {
      margin: 0 auto;
    }
  }

  .how-to-use {
    width: 100%;
    height: 500px;

    @include tab {
      height: 300px
    }

    @include sp {
      height: 200px;
    }
  }
</style>
