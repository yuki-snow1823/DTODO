<template>
  <v-container>
    <p>ご褒美ページです</p>
    <p>お名前：{{user.name}}</p>
    <p class="user-tp d-inline-block ">タスクポイント：{{user.point}}</p>
    <AddReward @submit="addReward" />
    <RewardList :rewards="user.rewards" />

  </v-container>
</template>

<script>
  import AddReward from "@/components/AddReward";
  import RewardList from "@/components/RewardList";
  import axios from "@/plugins/axios";
  import firebase from "@/plugins/firebase";
  export default {
    data() {
      return {
        name: "",
        point: "",
        show1: false,
        show2: false,
        error: "",
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
      AddReward,
      RewardList
    },
    // ログイン時のくるくるをいれたい
    computed: {
      user() {
        return this.$store.state.currentUser;
      }
      // カレントユーザーの定義
    },
    methods: {
      async addReward(reward) {
        // 子から送られてきたrewardを持っている
        const {
          data
        } = await axios.post("/v1/rewards", {
          reward
        });
        this.$store.commit("setUser", {
          ...this.user,
          rewards: [...this.user.rewards, data]
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

  .user-tp {
    border: white solid 2px;
  }
</style>
