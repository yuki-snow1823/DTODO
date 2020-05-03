<template>
  <div>
    <!-- <button @click="$tours['myTour'].start()" class="btn btn-lg">Start the tour</button>
    <button @click="nextStep" class="btn btn-lg">Next step</button>
    <button @click="showLastStep" class="btn btn-lg">Show last step</button> -->

    <v-tour name="myTour" :steps="steps" :callbacks="callbacks">
      <template slot-scope="tour">
        <transition name="fade">
          <v-step
            v-if="tour.currentStep === index"
            v-for="(step, index) of tour.steps"
            :key="index"
            :step="step"
            :previous-step="tour.previousStep"
            :next-step="tour.nextStep"
            :stop="tour.stop"
            :is-first="tour.isFirst"
            :is-last="tour.isLast"
            :labels="tour.labels"
          >
            <template v-if="tour.currentStep === 1">
              <div>
                <button @click="tour.previousStep" class="btn btn-primary">
                  Previous step
                </button>
                <button @click="tour.nextStep" class="btn btn-primary">
                  Next step
                </button>
              </div>
            </template>
          </v-step>
        </transition>
      </template>
    </v-tour>
  </div>
</template>

<script>
export default {
  name: "my-tour",
  data() {
    return {
      steps: [
        {
          target: "#v-step-0",
          header: {
            title: "ごほうびの登録"
          },
          content: `ここでごほうびを登録しましょう。（例：ゲームを１時間する！）<br>
          <strong>TPはここでは１にしておきましょう。</strong><br>
          登録したら次に進んでください。`,
            params: {
              placement: 'top'
            },
        },
        {
          target: "#v-step-1",
          header: {
            title: "TODOの一覧"
          },
          params: {
            placement: "bottom"
          },
          content:
            `鍵がかかった状態で登録されるので、実際に使うには<strong>ハートのマークを押してごほうびを解放しましょう。</strong><br>
            ご褒美を解放したら次に進んでください。`
        },
        {
          target: "#v-last-2",
          header: {
            title: "ごほうびの実行"
          },
          content:
           `ご褒美が解放され、鍵が開き、その分タスクポイントが消費されました。<br>
            実際に使ったごほうびは<strong>ゴミ箱マークをクリックして、削除しましょう。</strong><br>
            無事削除できたら、これでチュートリアルは終わりです！<br>
            ※ご褒美を削除しない限りチュートリアルは再生されます。（テストユーザーは削除しても再生されます。）<br>
            <strong style="color: cyan; -webkit-font-smoothing: antialiased !important;">メンドクサイを楽しんでいきましょう！</strong>`,
          params: {
            placement: "bottom"
          }
        }
      ],
      callbacks: {
        onPreviousStep: this.myCustomPreviousStepCallback,
        onNextStep: this.myCustomNextStepCallback
      }
    };
  },
  mounted: function() {
    this.$tours["myTour"].start();

    // A dynamically added onStop callback
    this.callbacks.onStop = () => {
      document
        .querySelector("#v-step-0")
        .scrollIntoView({ behavior: "smooth" });
    };
  },
  methods: {
    nextStep() {
      this.$tours["myTour"].nextStep();
    },
    showLastStep() {
      this.$tours["myTour"].currentStep = this.steps.length - 1;
    },
    myCustomPreviousStepCallback(currentStep) {
      console.log(
        "[Vue Tour] A custom previousStep callback has been called on step " +
          (currentStep + 1)
      );
    },
    myCustomNextStepCallback(currentStep) {
      console.log(
        "[Vue Tour] A custom nextStep callback has been called on step " +
          (currentStep + 1)
      );

      if (currentStep === 1) {
        console.log(
          "[Vue Tour] A custom nextStep callback has been called from step 2 to step 3"
        );
      }
    }
  }
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
