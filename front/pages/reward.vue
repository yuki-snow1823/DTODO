<template>
  <v-container>
    <div v-if="user">
      <p>ご褒美ページです</p>
      <p>お名前：{{user.name}}</p>
      <p class="user-tp d-inline-block ">タスクポイント：{{user.point}}</p>
      <AddReward @submit="addReward" />
      <RewardList :rewards="user.rewards" />
    </div>
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
      AddReward,
      RewardList
    },
    computed: {
      user() {
        return this.$store.state.currentUser;
      }
    },
    methods: {
      async addReward(reward) {
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

  .user-tp {
    border: white solid 2px;
  }
</style>
