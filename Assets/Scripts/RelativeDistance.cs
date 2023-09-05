using UnityEngine;

public class RelativeDistance : MonoBehaviour
{
    public Transform target; // The original parent transform
    public Vector3 distance; // The specific distance to keep from the target on each axis

    private Vector3 initialWorldScale;
    private Vector3 relativePosition;

    void Start()
    {
        // Capture the initial world scale of the GameObject
        initialWorldScale = transform.lossyScale;
        // Compute the initial relative position
        relativePosition = transform.position - target.position;
    }

    void Update()
    {
        // Maintain the initial world scale
        transform.localScale = initialWorldScale;

        // Keep the specific distance from the target
        Vector3 targetPosition = target.position + new Vector3(relativePosition.x > 0 ? distance.x : -distance.x,
                                                              relativePosition.y > 0 ? distance.y : -distance.y,
                                                              relativePosition.z > 0 ? distance.z : -distance.z);
        transform.position = targetPosition;
    }
}