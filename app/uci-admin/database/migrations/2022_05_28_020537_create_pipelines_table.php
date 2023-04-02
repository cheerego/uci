<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePipelinesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pipelines', function (Blueprint $table) {
            $table->id();
            $table->integer("workflow_id");
            $table->integer("number")->default(0);
            $table->string("uuid")->default("");
            $table->string("salt")->default("");
            $table->text("yaml");

            $table->text("triggered_cause");
            $table->text("failed_cause");

            $table->string("status")->default("BUILD_QUEUING");
            $table->string("status_message")->default("");
            $table->timestamp("last_status_changed_at")->nullable();

            $table->text("envs");

            $table->integer("runner_id")->default(0);
            $table->timestamp("first_borrow_runner_at")->nullable();
            $table->timestamp("borrow_runner_succeed_at")->nullable();
            $table->timestamp("release_runner_at")->nullable();


            $table->timestamp("started_at")->nullable();
            $table->timestamp("closed_at")->nullable();
            $table->integer("duration")->default(0);


            $table->text("raw_log");
            $table->text("prepare_log");

            $table->integer("dispatch_times")->default(0);
            $table->timestamp("first_dispatched_at")->nullable();
            $table->timestamp("last_dispatched_at")->nullable();
            $table->timestamp("dispatch_succeed_at")->nullable();


            $table->json("time_consuming")->nullable();


            $table->timestamps();
            $table->softDeletes();

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pipelines');
    }
}
