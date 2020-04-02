<template>
  <v-container>
    <!-- <div v-if="user">
    <p>{{user.name}}</p>
    <p>{{user.id}}</p>
    <AddTodo @submit="addTodo" />
    <TodoList :todos="user.todos" /> -->

    <h1 class="text-center orange">DTODO</h1>
    <v-row>
      <v-col cols="12" sm="12" md="4" lg="6">
        <h2 class="mb-3 text-center">タスク管理をゲームに！</h2>
        <h3>これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。
          これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介文です。これは紹介</h3>
      </v-col>
      <v-col cols="12" sm="12" md="4" lg="6">
        <form>
          <h2>新規登録はコチラ</h2>
          <v-text-field v-model="name" :counter="10" label="Name" data-vv-name="name" required></v-text-field>
          <v-text-field v-model="email" :counter="20" label="Email" data-vv-name="email" required></v-text-field>
          <v-text-field v-model="password" label="password" data-vv-name="password" required
            :type="show1 ? 'text' : 'password'" :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show1 = !show1"></v-text-field>
          <v-text-field v-model="passwordConfirm" label="passwordConfirm" data-vv-name="passwordConfirm" required
            :type="show2 ? 'text' : 'password'" :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show2 = !show2"></v-text-field>
          <v-btn class="mr-4" @click="signup">submit</v-btn>
          <p v-if="error" class="errors">{{error}}</p>
        </form>
      </v-col>
    </v-row>



  </v-container>
</template>

<script>
  import AddTodo from "@/components/AddTodo";
  import TodoList from "@/components/TodoList";
  import axios from "@/plugins/axios";

  export default {
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
        const {
          data
        } = await axios.post("/v1/todos", {
          todo
        });
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
