<template>
  <v-container class="user-page" v-if="currentUser">
    <Status />
    <v-row justify="center">
      <v-col class="pb-0" cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <AddReward @submit="addReward" :reward="currentUser.reward" />
        </div>
      </v-col>
    </v-row>

    <div class="errors text-center" v-if="$store.state.errors">
      <span v-for="error in $store.state.errors" :key="error">
        <div>{{ error }}</div>
      </span>
    </div>

    <v-row justify="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <RewardList :rewards="currentUser.rewards" />
        </div>
      </v-col>
    </v-row>
    <TourReward v-if="currentUser.user.reward_tour" />
  </v-container>
</template>

<script>
  import AddReward from "@/components/AddReward";
  import RewardList from "@/components/RewardList";
  import axios from "@/plugins/axios";
  import firebase from "@/plugins/firebase";
  import TourReward from '@/components/TourReward'
  import Status from "@/components/Status"


  export default {
    data() {
      return {
        email: "",
        name: "",
        level: "",
        point: "",
        experience_point: "",
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
            return redirect("/");
          }
        }
      );
    },
    components: {
      Status,
      AddReward,
      RewardList,
      TourReward
    },
    computed: {
      currentUser() {
        return this.$store.state.currentUser;
      }
    },
    methods: {
      async addReward(reward) {
        try {
          const {
            data
          } = await axios.post("/v1/rewards", {
            reward
          });
          const userReward = this.currentUser.rewards ? this.currentUser.rewards : []
          this.$store.commit("setUser", {
            ...this.currentUser,
            rewards: [...userReward, data]
          });
          this.$store.commit("clearErrors");
        } catch (error) {
          console.log("UserPage: 110", error);
          const {
            data
          } = error.response;
          this.$store.commit("setUser", {
            ...this.currentUser,
            reward: data.reward
          });
          this.$store.commit("setError", data.error_msg);
        }
      },
      logOut() {
        firebase
          .auth()
          .signOut()
          .then(() => {
            this.$store.commit("setUser", null);
            this.$router.push("/");
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  };
</script>

<style lang="scss">
  $main-color: #fc7b03;
  $sub-color: #33dddd;
  $accent-color: #f0353f;

  $pc: 1024px;
  $tab: 680px;
  $sp: 480px;

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

  .user-page {

    .user-btn {
      background-color: black !important;
      border: 2px solid $main-color;
      color: $main-color;
      width: 100%;
      font-weight: bold;
      font-size: 18px;

      &:hover {
        border: 2px solid yellow;
        color: yellow;
      }
    }

    .list-title,
    h1 {
      text-align: center;
      color: $sub-color;
    }

    a {
      text-decoration: none;
    }

    p {
      font-size: 20px;
      font-weight: bold;
    }

    .mdi-heart {
      color: red !important;
    }

    .errors {
      color: $accent-color;
    }
  }
</style>
