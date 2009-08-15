<?php get_header(); ?>

<?php query_posts('category_name=Featured&showposts=1'); ?>
<?php if (have_posts()) : while (have_posts()) : the_post(); ?>

	<?php include (TEMPLATEPATH . '/loop_poem.php'); ?>

<?php endwhile; else: ?>

<div id="main" class="clearfloat">
<div class="wrapper">

<div id="content">
		<h2>Getting Started</h2>
		<p>Select a poem to begin.</p>

<?php endif; ?>
<?php query_posts(''); ?>

</div><!--/content-->
	
<?php get_sidebar(); ?>

<?php get_footer(); ?>

