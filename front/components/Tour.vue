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
                <button @click="tour.previousStep" class="btn btn-primary">Previous step</button>
                <button @click="tour.nextStep" class="btn btn-primary">Next step</button>
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
    name: 'my-tour',
    data () {
      return {
        steps: [
          {
            target: '#v-step-0',
            header: {
              title: 'TODOの追加'
            },
            content: `まず、ここでTODOを登録しましょう。<br>TPは「タスクポイント」の略称です。<br>
            TODOを達成した時にもらえるポイントなので、大変なTODOほど大きな数のTPを設定しましょう。<br>
            TP「1」のTODOを登録したら次に進んでください。`,
            params: {
              placement: 'top'
            },
          },
          {
            target: '#v-step-1',
            header: {
              title: 'TODOの一覧'
            },
            params: {
              placement: 'bottom'
            },
            content: '左の数字がそのTODOのタスクポイントを示します。<br>ハートのアイコンで達成、鉛筆のアイコンで編集、ゴミ箱のアイコンで削除ができます。<br>ハートのアイコンを押して、達成してみましょう。'
          },
          {
            target: '#v-step-2',
            content: 'タスクポイントが増えました。<br>また、TODOを達成する度、あなたのレベルはアップします。<br>最大のレベル10を目指して毎日のTODOに取り組みましょう。',
            params: {
              placement: 'bottom'
            }
          },
          {
            target: '#v-step-3',
            header: {
              title: 'メニューの一覧'
            },
            content: '貯まったタスクポイントはごほうびを解放するために使えます。<br>三本線のアイコンをクリックしてメニューを開き、ごほうびページにいってみましょう。',
            params: {
              placement: 'top'
            }
          },
        ],
        callbacks: {
          onPreviousStep: this.myCustomPreviousStepCallback,
          onNextStep: this.myCustomNextStepCallback,
          onFinish: this.myCustomFinishCallback,
        }
      }
    },
    mounted: function () {
      this.$tours['myTour'].start()

      // A dynamically added onStop callback
      this.callbacks.onStop = () => {
        document.querySelector('#v-step-0').scrollIntoView({behavior: 'smooth'})
      }
    },
    methods: {
      nextStep () {
        this.$tours['myTour'].nextStep()
      },
      showLastStep () {
        this.$tours['myTour'].currentStep = this.steps.length - 1
      },
      myCustomPreviousStepCallback (currentStep) {
        console.log('[Vue Tour] A custom previousStep callback has been called on step ' + (currentStep + 1))
      },
      myCustomNextStepCallback (currentStep) {
        console.log('[Vue Tour] A custom nextStep callback has been called on step ' + (currentStep + 1))

        if (currentStep === 1) {
          console.log('[Vue Tour] A custom nextStep callback has been called from step 2 to step 3')
        }
      },
      myCustomFinishCallback() {
        this.$emit('finished')
      }
    }
  }
</script>

<style scoped>
  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
  }

  .fade-enter, .fade-leave-to {
    opacity: 0;
  }
</style>
