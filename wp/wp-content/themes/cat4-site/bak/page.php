<?php get_header(); ?>

<?php include_once (TEMPLATEPATH . "/child_navigation.php"); ?>

<ul id="nav" class="wrapper clearfloat">
	<li><a href="/">Home</a></li>
	<?php if($section_title && $section_overview_link) : ?>
	<li class="current_page_item"><a href="<?php echo $section_overview_link; ?>" rel="bookmark"><?php echo $section_title; ?></a></li>
	<?php else : ?>
	<li class="current_page_item"><a href="<?php the_permalink() ?>" rel="bookmark"><?php the_title(); ?></a></li>
	<?php endif; ?>
</ul>

<div id="main" class="clearfloat">
<div class="wrapper">

<?php if (have_posts()) : while (have_posts()) : the_post(); ?>
<div id="content">

<?php if($children) : ?>
	<div id="subnav-wrapper">
	<ul id="subnav">
	<?php echo $section_overview; ?>
	<?php echo $children; ?>
	</ul>
	</div>
<?php endif; ?>

		<h2><?php the_title(); ?></h2>
		<div class="entry">
			<?php the_content(); ?>
		</div>
	
</div><!--END COLUMN-->
<?php endwhile; endif; ?>

<?php get_sidebar(); ?>


<?php get_footer(); ?>