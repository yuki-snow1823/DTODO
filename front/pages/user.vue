<template>
  <v-container class="user-page" v-if="currentUser">
    <Status class="mb-5" />
    <AddTodo class="mb-5" @submit="addTodo" :todo="currentUser.todo" />
    <div class="text-center" v-if="$store.state.errors">
      <span v-for="error in $store.state.errors" :key="error">
        <div class="errors mb-1">{{ error }}</div>
      </span>
    </div>
    <TodoList :todos="currentUser.todos" />
    <Tour v-if="currentUser.user.todo_tour" />
  </v-container>
</template>

<script>
  import AddTodo from "@/components/AddTodo";
  import TodoList from "@/components/TodoList";
  import axios from "@/plugins/axios";
  import firebase from "@/plugins/firebase";
  import Tour from "@/components/Tour";
  import Status from "@/components/Status"

  export default {
    data() {
      return {
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
          // console.log(newUser, oldUser);
          if (!newUser) {
            return redirect("/");
          }
        }
      );
    },
    components: {
      Status,
      AddTodo,
      TodoList,
      Tour,
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
          const userTodo = this.currentUser.todos ? this.currentUser.todos : [];
          this.$store.commit("setUser", {
            ...this.currentUser,
            todos: [...userTodo, data]
          });
          this.$store.commit("clearErrors");
        } catch (error) {
          const {
            data
          } = error.response;
          this.$store.commit("setUser", {
            ...this.currentUser,
            todo: data.todo
          });
          this.$store.commit("setError", data.error_msg);
        }
      }
    }
  };
</script>

<style lang="scss">
.errors {
  color: red;
}
</style>
