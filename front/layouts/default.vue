<template>
  <v-app dark>
    <Loading />
    <Success />
    <!-- 追加したものたち -->
    <v-navigation-drawer v-model="drawer" :mini-variant="miniVariant" :clipped="clipped" fixed app>
      <v-list>
        <v-list-item v-for="(item, i) in items" :key="i" :to="item.to" router exact>
          <v-list-item-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title v-text="item.title" />
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar :clipped-left="clipped" fixed app>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
      <!-- <v-btn icon @click.stop="miniVariant = !miniVariant"> -->
        <!-- <v-icon>mdi-{{ `chevron-${miniVariant ? 'right' : 'left'}` }}</v-icon> -->
      <!-- </v-btn> -->
      <!-- <v-btn icon @click.stop="clipped = !clipped"> -->
        <!-- <v-icon>mdi-application</v-icon> -->
      <!-- </v-btn> -->
      <!-- <v-btn icon @click.stop="fixed = !fixed"> -->
        <!-- <v-icon>mdi-minus</v-icon> -->
      <!-- </v-btn> -->
      <v-toolbar-title v-text="title" />
      <v-spacer />
      <v-btn icon @click.stop="rightDrawer = !rightDrawer">
        <v-icon>mdi-menu</v-icon>
      </v-btn>
    </v-app-bar>
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <v-navigation-drawer v-model="rightDrawer" :right="right" temporary fixed>
      <v-list>
        <v-list-item @click.native="right = !right">
          <v-list-item-action>
            <v-icon light>mdi-repeat</v-icon>
          </v-list-item-action>
          <v-list-item-title>Switch drawer (click me)</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-footer :fixed="fixed" app>
      <span>&copy; 2019</span>
    </v-footer>
  </v-app>
</template>

<script>
import Loading from "@/components/Loading";
import Success from "@/components/Success"

export default {
  data() {
    return {
      clipped: false,
      drawer: false,
      fixed: false,
      miniVariant: false,
      right: true,
      rightDrawer: false,
      title: "DTODO" //追加
    };
  },
    components: {
    Loading,　　//追加
    Success
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    },
    items() {
      if (this.user) {
        return [
          {
            icon: "mdi-apps",
            title: "Todos",
            to: "/"
          },
          {
            icon: "mdi-chart-bubble",
            title: "mypage",
            to: "/mypage"
          }
        ];
      } else {
        return [
          {
            icon: "mdi-apps",
            title: "ログイン",
            to: "/login"
          },
          {
            icon: "mdi-chart-bubble",
            title: "新規登録",
            to: "/signup"
          }
        ];
      }
    }
 }
}

</script>

<style>
.v-content__wrap {
  background-color: black !important;
}
</style>
