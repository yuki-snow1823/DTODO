<template>
  <v-card>
    <v-card-title>
      <h2>TODO</h2>
      <v-spacer></v-spacer>
      <!-- <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field> -->
      <!-- 残してもいいかも -->
    </v-card-title>
    <v-data-table :headers="headers" :items="todos" :search="search">
      <!-- ここにアイテムの名前が表示される -->
      <template v-slot:item.action="{ item }">
        <v-icon small @click="deleteItem(item)">delete</v-icon>
      </template>
    </v-data-table>
  </v-card>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  props: ["todos"],
  data() {
    return {
      singleSelect: true,
      selected: [],
      search: "",
      headers: [
        { 
          text: "チェック！", 
          width: '170' ,
          value: "title"
          // 幅の固定もできる
        },
       { 
          text: "TASK POINT", 
          width: '170' 
          // 幅の固定もできる
        },
        // これ押したらチェックするみたいな感じにしたい
        {
          text: "内容",
          align: "left",
          sortable: false,
          value: "title"
        },
        // { text: "ユーザー名", value: "username" },
        { text: "Actions", 
          value: "action", 
          sortable: false }
      ]
    };
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  methods: {
    async deleteItem(item) {
      const res = confirm("本当に削除しますか？");
      if (res) {
        await axios.delete(`/v1/todos/${item.id}`);
        const todos = this.user.todos.filter(todo => {
          return todo.id !== item.id;
        });
        const newUser = {
          ...this.user,
          todos
        };
        this.$store.commit("setUser", newUser);
      }
    }
  }
};
</script>

<style>
</style>
