<template>
  <v-container class="user-page" v-if="currentUser">
    <v-row class="user-status" justify="center">
      <v-col cols="12" xs="5" sm="6" md="5" lg="4">
        <h1>STATUS</h1>
        <p>NAME：{{currentUser.user.name}}</p>
        <p>LV：{{currentUser.user.level}}</p>
        <p>EXP：{{currentUser.user.experience_point}}</p>
        <p>TP：{{currentUser.user.point}}</p>
      </v-col>

      <v-col cols="12" xs="5" sm="6" md="5" lg="4">
        <v-hover v-slot:default="{ hover }">
          <router-link to="/user">
            <v-btn class="user-btn my-10">
              <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>TODO PAGE
            </v-btn>
          </router-link>
        </v-hover>
        <v-hover v-slot:default="{ hover }">
          <v-btn class="user-btn" @click="logOut">
            <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>LOG OUT
          </v-btn>
        </v-hover>
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <AddReward @submit="addReward" />
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
      AddReward,
      RewardList
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
          console.log(data);
          this.$store.commit("setUser", {
            ...this.currentUser,
            rewards: [...this.currentUser.rewards, data]
          });
          this.$store.commit("clearErrors");
        } catch (error) {
          console.log(error);
          const {
            data
          } = error.response;
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
      },
    }
  };
</script>

<style lang="scss">
  $main-color: #fc7b03;
  $sub-color: #33dddd;

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
    .user-status {
      border: 2px white solid;
      margin: 0 auto;
      width: 66%;
    }

    .user-status {
      @include pc {
        width: 100% !important;
      }

      ;

      @include tab {
        width: 100% !important;
      }

      ;

      @include sp {
        width: 100% !important;
      }

      ;
    }

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

    h2,
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
  }
</style>
