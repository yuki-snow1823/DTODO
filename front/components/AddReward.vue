<template>

  <v-form>
    <v-container class="add-todo">
      <v-row>
        <v-col class="pr-0 pb-0" cols="3" xs="2" sm="2" md="2" lg="2">
          <v-select label="必要TP" v-model="number" :items="items" outlined></v-select>
        </v-col>
        <v-col class="pl-0 pb-0" cols="9" xs="8" sm="8" md="8" lg="8">
          <v-text-field v-model="title" :counter="20" label="ごほうびの内容" required outlined></v-text-field>
        </v-col>
        <v-col class="px-0 pb-0" cols="12" xs="2" sm="2" md="2" lg="2">
          <v-hover v-slot:default="{ hover }">
            <v-btn class="todo-btn my-2 mx-1" @click="handleSubmit">
              <v-icon v-text="hover ? 'mdi-heart' : ''">
              </v-icon>
              登録
            </v-btn>
          </v-hover>
        </v-col>
      </v-row>
    </v-container>
  </v-form>

</template>
<script>
  const maxNumber = 11;
  const numberRange = [...Array(maxNumber).keys()]
  export default {
    data() {
      return {
        title: "",
        items: numberRange,
        number: '',
      };
    },
    methods: {
      handleSubmit() {
        const reward = {
          title: this.title,
          user_id: this.$store.state.currentUser.user.id,
          point: this.number
        };
        this.$emit("submit", reward);
        this.title = "";
        this.number = "";
      }

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
    width: 90%;
  }

  .add-todo {
    border: 2px white solid;

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
