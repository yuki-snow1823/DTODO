<template>
      <v-row class="add-todo">
        <v-col id="v-step-0" class="pr-0 pb-0" cols="4" xs="2" sm="2" md="2" lg="2">
          <v-select class="point" label="TP" v-model="todo.point" :items="items" outlined></v-select>
        </v-col>
        <v-col class="pl-0 pb-0" cols="8" xs="8" sm="8" md="8" lg="8">
          <v-text-field id="todo-title" class="text" name="text" v-model="todo.title" :counter="20" label="TODOの内容"
            required outlined></v-text-field>
        </v-col>
        <v-col class="px-0 pb-0" cols="12" xs="12" sm="2" md="2" lg="2">
          <v-hover v-slot:default="{ hover }">
            <v-btn class="todo-btn" @click="handleSubmit">
              <v-icon color="red" v-text="hover ? 'mdi-heart' : ''"></v-icon>登録
            </v-btn>
          </v-hover>
        </v-col>
      </v-row>
</template>

<script>
  const numberRange = [...Array(9).keys()].map(i => ++i);
  export default {
    props: {
      todo: {
        type: Object,
        'default': () => ({ title:"",point: 0 }) ,
        required: true
      }
    },
    data() {
      return {
        items: numberRange
      };
    },
    methods: {
      handleSubmit() {
        const todo = {
          title: this.todo.title,
          user_id: this.$store.state.currentUser.user.id,
          point: this.todo.point
        };
        this.$emit("submit", todo);
        // 登録後に入力した値をリセットしています。
        this.todo.title = "";
        this.todo.point = "";
      }
    },
    created() {
      this.$vuetify.lang = {
        t: () => {}
      };
      //testを実行する際に直接関係ないエラーを回避する為に記述してあります。
    }
  };
</script>

<style lang="scss">
  $main-color: #fc7b03;

  .add-todo {

    .todo-btn {
      background-color: black !important;
      border: 2px solid $main-color;
      color: $main-color;
      display: inline-block;
      font-weight: bold;
      font-size: 25px;
      padding-bottom: 35px !important;
      padding-top: 17px !important;
      margin-left: 5%;
      width: 90%;

      &:hover {
        border: 2px solid yellow;
        color: yellow;
      }

      span {
        margin-top: -9px;
      }
    }
  }
</style>
