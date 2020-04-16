<template>
  <div>
    <v-card>
      <v-card-title>
        <h2 class="list-title">TODO LIST</h2>
        <v-spacer></v-spacer>
      </v-card-title>
      <ul>
          <li><span>【達成ボタン】</span>あああ【編集ボタン】</li>
        <draggable v-model="todos">
          <li v-for="todo in todos" :key="todo.point">
            ポイント{{ todo.point }}：{{ todo.title }}
          </li>
        </draggable>
      </ul>
    </v-card>
    <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
      {{ snackText }}
      <v-btn text @click="snack = false">Close</v-btn>
    </v-snackbar>
  </div>

</template>

<script>
  const maxNumber = 11;
  const numberRange = [...Array(maxNumber).keys()]
  // import draggable from '@/plugins/vue-draggable';
  // 追記した
  import axios from "@/plugins/axios";
  export default {
    props: ["todos"],
    data() {
      return {
        singleSelect: true,
        selected: [],
        search: "",
        editOn: true,
        items: numberRange,
        snack: false,
        snackColor: "",
        snackText: "",
        // draggable: true
        // これが必要
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
          const updateUser = {
            ...this.user,
            todos
          };
          this.$store.commit("setUser", updateUser);
          this.snack = true;
          this.snackColor = "warning";
          this.snackText = "Data deleted";
        }
      },
      async completeItem(item) {
        const res = confirm("本当に達成しますか？");
        if (res) {
          const getUser = await axios.get(`/v1/todos/${item.id}`, {
            params: {
              point: item.point
            }
          });
          console.log(getUser.data.user.point);
          const todos = this.user.todos.filter(todo => {
            return todo.id !== item.id;
          });
          this.user.level = getUser.data.user.level;
          this.user.point = getUser.data.user.point;
          this.user.experience_point = getUser.data.user.experience_point;
          const updateUser = {
            ...this.user,
            todos
          };
          this.$store.commit("setUser", updateUser);
          this.snack = true;
          this.snackColor = "success";
          this.snackText = "Data saved";
        }
      },
      async editItem(item) {
        this.editOn = !this.editOn;
      },
      async updateTitle(id, value) {
        await axios.patch(`/v1/todos/${id}`, {
          todo: {
            title: value
          }
        });
      },
      async updatePoint(id, value) {
        let result =
          await axios.patch(`/v1/todos/${id}`, {
            todo: {
              point: value
            }
          });
      },
      save() {
        this.snack = true;
        this.snackColor = "success";
        this.snackText = "Data saved";
      },
      cancel() {
        this.snack = true;
        this.snackColor = "error";
        this.snackText = "Canceled";
      },
      open() {
        this.snack = true;
        this.snackColor = "info";
        this.snackText = "Dialog opened";
      },
      close() {
        console.log("Dialog closed");
      }
    },
    watch: {}
  };
</script>

<style>
  .v-icon {
    display: flex;
    justify-content: center;
  }

  .edit-window {
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
</style>
