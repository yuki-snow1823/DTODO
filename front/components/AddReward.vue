<template>
  <v-form>
    <v-container class="add-reward">
      <v-row>
        <v-col id="v-step-0" class="pr-0 pb-0" cols="4" xs="2" sm="2" md="2" lg="2">
          <v-select label="TP" v-model="reward.point" :items="items" outlined></v-select>
        </v-col>
        <v-col class="pl-0 pb-0" cols="8" xs="8" sm="8" md="8" lg="8">
          <v-text-field id="reward-title" v-model="reward.title" :counter="20" label="ごほうびの内容" required outlined>
          </v-text-field>
        </v-col>
        <v-col class="px-0 pb-0" cols="12" xs="2" sm="2" md="2" lg="2">
          <v-hover v-slot:default="{ hover }">
            <v-btn class="reward-btn" @click="handleSubmit">
              <v-icon v-text="hover ? 'mdi-heart' : ''"></v-icon>
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
    props: {
      reward: {
        type: Object,
        default: {
          title: "",
          point: null
        },
        required: true // プロパティを絶対渡すと言うこと
      }
    },
    data() {
      return {
        items: numberRange,
      };
    },
    methods: {
      handleSubmit() {
        const reward = {
          title: this.reward.title,
          user_id: this.$store.state.currentUser.user.id,
          point: this.reward.point
        };
        this.$emit("submit", reward);
        this.reward.title = "";
        this.reward.point = "";
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
    font-size: 25px;
    padding-bottom: 35px !important;
    padding-top: 17px !important;
    margin-left: 5%;
    width: 90%;
  }

  .add-reward {
    border: 2px white solid;

    .reward-btn {
      @include btn;

      &:hover {
        border: 2px solid yellow;
        color: yellow;
      }

      span {
        margin-top: -9px;
      }
    }

    .mdi-heart {
      color: red !important;
    }
  }
</style>
