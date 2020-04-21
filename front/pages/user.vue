<template>
  <v-container class="user-page" v-if="currentUser">
    <v-row class="user-status" id="v-step-2">
      <v-col cols="12" xs="5" sm="6" md="5" lg="5">
        <p>名前：{{ currentUser.user.name }}<v-icon class="mb-2" color="yellow" size="30" v-if="currentUser.user.level == 10">mdi-crown</v-icon></p>
        <div class="user-point">
          <p class="user-task-point">TP:{{ currentUser.user.point }}</p>
        </div>
      </v-col>

      <v-col cols="12" xs="5" sm="6" md="5" lg="5">
        <p class="user-level">レベル：{{ currentUser.user.level }}</p>
        <p v-if="currentUser.user.level !== 10">次のレベルまであと {{ currentUser.untilLevel ? currentUser.untilLevel: 50 }} EXP</p>
        <p v-else>最大レベルです！</p>
        <v-progress-linear :height="12" :rounded="true"
          :value="currentUser.untilPercentage ? currentUser.untilPercentage : 0" color="light-blue">
        </v-progress-linear>

      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col class="pb-0" cols="12" xs="12" sm="12" md="12" lg="8">
        <div>
          <AddTodo @submit="addTodo" />
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
          <TodoList :todos="currentUser.todos" />
        </div>
      </v-col>
    </v-row>
    <Tour v-if="currentUser.user.todo_tour" />

  </v-container>
</template>

<script>
  import AddTodo from "@/components/AddTodo";
  import TodoList from "@/components/TodoList";
  import axios from "@/plugins/axios";
  import firebase from "@/plugins/firebase";
  import Tour from '@/components/Tour'

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
      AddTodo,
      TodoList,
      Tour
    },
    computed: {
      currentUser() {
        return this.$store.state.currentUser;
      }
    },
    methods: {
      async addTodo(todo) {
        try {
          const {
            data
          } = await axios.post("/v1/todos", {
            todo
          });
          console.log(this.currentUser);
          const userTodo = this.currentUser.todos ? this.currentUser.todos : []
          this.$store.commit("setUser", {
            ...this.currentUser,
            todos: [...userTodo, data]
          });
          this.$store.commit("clearErrors");
        } catch (error) {
          console.log("UserPage: 110", error);
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
    .user-status {
      border: 2px white solid;
      margin: 0 auto;
      width: 66%;
      background-color: rgb(60, 60, 65);

      .coin-img {
        width: 20% !important;
        display: inline-block;
      }

      .user-point {
        display: flex;
        .user-task-point {
          font-size: x-large;
          color: rgb(238, 238, 37);
          padding-left: 2%;
          padding-top: 8px;
          margin-bottom: 0px;
        }
      }
    }

    .user-status {
      @include pc {
        width: 100%;
      }

      @include tab {
        width: 100% !important;
      }

      @include sp {
        width: 100% !important;
      }
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

    .list-title,
    h1 {
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
