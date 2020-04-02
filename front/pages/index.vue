<template>
  <div v-if="user">
    <p>{{user.name}}</p>
    <p>{{user.id}}</p>
    <AddTodo @submit="addTodo" />
    <TodoList :todos="user.todos" /> 
  </div>
</template>

<script>
import AddTodo from "@/components/AddTodo";
import TodoList from "@/components/TodoList";
import axios from "@/plugins/axios";

export default {
  fetch({ store, redirect }) {
    store.watch(
      state => state.currentUser,
      (newUser, oldUser) => {
        if (!newUser) {
          return redirect("/login");
        }
      }
    );
  },
  // 多分ここ
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
    async addTodo(todo) {
      const { data } = await axios.post("/v1/todos", { todo });
      //追加
      this.$store.commit("setUser", {
        ...this.user,
        todos: [...this.user.todos, data] 
        // 初期値ではなくpostできるように
      });
    }
  }
};

</script>

<style>
</style>
