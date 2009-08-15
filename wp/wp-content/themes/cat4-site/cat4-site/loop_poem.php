<?php
$application = get_post_meta($post->ID, 'Application', TRUE);
$posttags = get_the_tags();
$count=0;
if ($posttags) {
	foreach($posttags as $tag) {
		$count++;
		if (1 == $count) {
			$query_tag = $tag->slug;
		}
	}
}
if ($query_tag) :
	global $post;
	$related_materials = get_posts('tag='.$query_tag.'&orderby=title&showposts=-1&order=asc');
	foreach($related_materials as $post) :
		if (in_category('Resources')) :
			$has_resources = 1;
		endif;
		if (in_category('Media')) :
			$has_media = 1;
		endif;
	endforeach;
endif; //$query_tag ?>

<ul id="nav" class="wrapper clearfloat">
	<li><a href="#poem">Poem</a></li>
	<?php if($has_media == 1) : ?><li><a href="#media">Media</a></li><?php endif; ?>
	<?php if($has_resources == 1) : ?><li><a href="#resources">Resources</a></li><?php endif; ?>
	<li><a href="#glossary">Glossary</a></li>
	<li><a href="#overview"><?php echo get_the_title('2'); ?></a></li>
</ul>

<div id="main" class="clearfloat">
<div class="wrapper">

<div id="content">

	<div id="poem" class="poem-content entry">
		<?php if($application) : ?>
		<div id="app">
		<iframe src="<?php echo $application; ?>" width="600" height="629">
			This application requires support for iframes. 
		</iframe>
		</div>
		<?php endif; ?>
	</div>

<?php if($has_media == 1) : ?>
	<div id="media" class="poem-content entry">
		<h2>Media</h2>
<?php
	foreach($related_materials as $post) : setup_postdata( $post );
		if (in_category('Media')) : ?>
		<dl class="media">
			<dt>Title:</dt>
			<dd><h4><?php the_title(); ?></h4></dd>
			<dt>Media:</dt>
			<dd><?php the_content(); ?></dd>
		</dl>
		<?php
		endif;
	endforeach;
?>
	</div>
<?php endif; //$has_media ?>



<?php if($has_resources == 1) : ?>
	<div id="resources" class="poem-content entry">
		<h2>Resources</h2>
<?php $first_def = ''; ?>
		<dl>
<?php
	foreach($related_materials as $post) : setup_postdata( $post );
		if (in_category('Resources')) :
			if($first_def == '') : ?>
			<dt class="first"><?php the_title(); ?>:</dt>
			<dd class="first"><?php the_content(); ?></dd>
			<?php $first_def = 'done'; ?>
			<?php else : ?>
			<dt><?php the_title(); ?>:</dt>
			<dd><?php the_content(); ?></dd>
			<?php endif;
		endif;
	endforeach;
?>
		</dl>
	</div>
<?php endif; //$has_resources ?>



<div id="glossary" class="poem-content entry">
		<h2>Glossary</h2>
		<?php include (TEMPLATEPATH . '/searchform.php'); ?>
<?php $first_def = ''; ?>
	<div id="results">
		<dl>
<?php
	global $more;
	$glossary_terms = get_posts('category_name=Glossary&orderby=title&showposts=-1&order=asc');
	foreach($glossary_terms as $post) : setup_postdata( $post ); ?>
		<dt<?php if($first_def == '') : ?> class="first"<?php endif; ?> id="reference_<?php echo $post->post_name; ?>"><?php the_title(); ?>:</dt>
		<?php $more = 0; ?>
		<dd<?php if($first_def == '') : ?> class="first"<?php endif; ?>><?php the_content('', FALSE, ''); ?>
		<?php $more = 1; ?>
		<?php $extended_content = get_the_content('', TRUE, ''); ?>		
		<?php if(strlen($extended_content) > 0) : ?>
			<a href="#more-<?php the_ID(); ?>" class="read-more">Show/Hide Expanded Definition</a>
			<div id="more-<?php the_ID(); ?>" class="read-more-text"><?php the_content('', TRUE, ''); ?></div>
		<?php endif; ?>
		</dd>
		<?php if($first_def == '') : $first_def = 'done'; endif;
	endforeach;
?>
		</dl>
	</div>
</div>

	<div id="overview" class="poem-content entry">
	<?php $temp_query = $wp_query; ?>
	<?php query_posts('showposts=1&pagename=about'); 
	if (have_posts()) : while (have_posts()) : the_post(); ?>
	<?php include_once (TEMPLATEPATH . "/child_navigation.php"); ?>
		 
		 <?php if($children) : ?>
			<div id="subnav-wrapper">
			<ul id="subnav">
			<?php echo $section_overview; ?>
			<?php echo $children; ?>
			</ul>
			</div>
		<?php endif; ?>
		
	<?php endwhile; endif; ?>
	<?php $wp_query = $temp_query; ?>
	</div>
