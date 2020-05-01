<template>
  <v-container class="user-page" v-if="currentUser">
    <Status class="mb-5"/>
    <AddReward class="mb-5" @submit="addReward" :reward="currentUser.reward" />
    <div class="text-center" v-if="$store.state.errors">
      <span v-for="error in $store.state.errors" :key="error">
        <div class="errors mb-1">{{ error }}</div>
      </span>
    </div>
    <RewardList :rewards="currentUser.rewards" />
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
.errors {
  color: red;
}
</style>
