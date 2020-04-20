<template>
  <v-form>
    <v-container class="add-todo">
      <v-row>
        <v-col
          id="v-step-0"
          class="pr-0 pb-0"
          cols="3"
          xs="2"
          sm="2"
          md="2"
          lg="2"
        >
          <v-select label="TP" v-model="number" :items="items" outlined
            >test</v-select
          >
        </v-col>
        <v-col class="pl-0 pb-0" cols="9" xs="8" sm="8" md="8" lg="8">
          <v-text-field
            v-model="title"
            :counter="20"
            label="TODOの内容"
            required
            outlined
          ></v-text-field>
        </v-col>
        <v-col class="px-0 pb-0" cols="12" xs="2" sm="2" md="2" lg="2">
          <v-hover v-slot:default="{ hover }">
            <v-btn class="todo-btn my-2 mx-1" @click="handleSubmit">
              <v-icon v-text="hover ? 'mdi-heart' : ''"> </v-icon>
              登録
            </v-btn>
          </v-hover>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
const numberRange = [...Array(9).keys()].map(i => ++i);

export default {
  data() {
    return {
      title: "",
      items: numberRange,
      number: ""
    };
  },
  methods: {
    handleSubmit() {
      const todo = {
        title: this.title,
        user_id: this.$store.state.currentUser.user.id,
        point: this.number
      };
      this.$emit("submit", todo);
      this.title = "";
      this.number = "";
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

@mixin btn {
  background-color: black !important;
  border: 2px solid $main-color;
  color: $main-color;
  display: inline-block;
  font-weight: bold;
  margin: 15px;
  width: 93%;
}

.add-todo {
  border: solid 2px white;

  .todo-btn {
    @include btn;

    &:hover {
      border: 2px solid yellow;
      color: yellow;
    }
  }

  .mdi-heart {
    color: red !important;
  }
}
</style>
