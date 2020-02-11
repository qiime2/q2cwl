.PHONY: render core-metrics emperor-plot beta-group-sig volatility confusion_matrix test

clean:
	rm -r **/out/*

render:
	q2cwl template conda tools/

core-metrics: render
	cwltool --outdir core-metrics/out tools/qiime2.plugins.diversity.pipelines.core_metrics_phylogenetic.cwl core-metrics/job.yaml

emperor-plot: render
	cwltool --outdir emperor-plot/out tools/qiime2.plugins.emperor.visualizers.plot.cwl emperor-plot/job.yaml

beta-group-sig: render
	cwltool --outdir beta-group-sig/out tools/qiime2.plugins.diversity.visualizers.beta_group_significance.cwl beta-group-sig/job.yaml

table-summary: render
	cwltool --outdir table-summary/out tools/qiime2.plugins.feature_table.visualizers.summarize.cwl table-summary/job.yaml

volatility: render
	cwltool --outdir volatility/out tools/qiime2.plugins.longitudinal.visualizers.volatility.cwl volatility/job.yaml

confusion-matrix: render
	cwltool --outdir confusion-matrix/out tools/qiime2.plugins.sample_classifier.visualizers.confusion_matrix.cwl confusion-matrix/job.yaml

exporting-file: render
	cwltool --outdir exporting-file/out tools/qiime2.tools.export.cwl exporting-file/job.yaml

exporting-dir: render
	cwltool --outdir exporting-dir/out tools/qiime2.tools.export.cwl exporting-dir/job.yaml

importing-file: exporting-file
	cwltool --outdir importing-file/out tools/qiime2.tools.import.cwl importing-file/job.yaml

importing-dir: exporting-dir
	cwltool --outdir importing-dir/out tools/qiime2.tools.import.cwl importing-dir/job.yaml

test: core-metrics emperor-plot beta-group-sig table-summary volatility confusion_matrix importing-file importing-dir
	:
